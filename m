Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbUK0JcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbUK0JcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 04:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUK0JcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 04:32:16 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:17412 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261165AbUK0JcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 04:32:13 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: pavel@ucw.cz (Pavel Machek)
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
Cc: mgarrett@chiark.greenend.org.uk, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20041127072224.GM1417@openzaurus.ucw.cz>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CXyvo-0002LS-00@gondolin.me.apana.org.au>
Date: Sat, 27 Nov 2004 20:31:52 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
>> name_to_dev_t needs to be non-init in order to make it possible to
>> trigger a resume when the block device driver isn't static. Pavel, would
>> you be willing to consider a patch to make it possible to trigger swsusp
>> resume from userspace? That gets things working with initrd kernels.
>> I've been using something along these lines for a few weeks now, and it
>> hasn't eaten my filesystem yet.
> 
> Given it is not too intrusive... why not. Send it for comments.
> I probably will not use this myself, so you'll need to test/maintain
> it.

This shouldn't be necessary.  Since the resume is being initiated by
userspace, it can perform the function of name_to_dev_t and just feed
the numbers to the kernel.  The code to do that is still in Debian's
initrd-tools.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
