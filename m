Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUFLXdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUFLXdm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 19:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUFLXdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 19:33:42 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.74]:38809 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264960AbUFLXdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 19:33:39 -0400
Date: Sat, 12 Jun 2004 19:32:42 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Fix memory leak in swsusp
In-reply-to: <40CB7EBD.2020109@linuxmail.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, herbert@gondor.apana.org.au, pavel@suse.cz,
       mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Message-id: <200406121932.49477.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <20040609130451.GA23107@elf.ucw.cz>
 <20040611210059.2522e02d.akpm@osdl.org> <40CB7EBD.2020109@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 12 June 2004 18:07, Nigel Cunningham wrote:
> Hi.
> At some stage, you copy the page that contains the preempt count for the
> process that is doing the suspending. If you use memcpy on a 3Dnow machine,
> the preempt count is incremented prior to doing the copy of the page. Then,
> at resume time, it is one too high.

Well, if we know that it is one too high, why not decrement right after the 
resume?

Jeff.

- -- 
"Reality is merely an illusion, albeit a very persistent one."
		- Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAy5KfwFP0+seVj/4RAlTXAJsFHALWNJ+mgVu7xEhfsk2Hqcq/wwCgmEmh
EpOv1mA9B35xcbzxT+lSHIo=
=Bn1K
-----END PGP SIGNATURE-----
