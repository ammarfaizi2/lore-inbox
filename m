Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUB0HIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 02:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUB0HIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 02:08:06 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:31640 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261743AbUB0HH6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 02:07:58 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: "Swap in" an entire process?
Date: Fri, 27 Feb 2004 08:05:20 +0100
User-Agent: KMail/1.6
References: <20040225161911.22361.qmail@web21203.mail.yahoo.com>
In-Reply-To: <20040225161911.22361.qmail@web21203.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402270805.32965.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Konstantin,

On Wednesday 25 February 2004 17:19, Konstantin Kudin wrote:
>  I have a question. Is there some way under linux to
> "swap in" an entire process that got partially swapped
> out?
> 
>  Basically, I want all the pages for a given PID
> returned to RAM if they were paged out.
 
The process to swap in can do that with mlockall().

>  And vice versa, is there a way to "swap out" a
> process by some command?

No, but munlockall will allow it to be swapped
again. It will swap out while sleeping gradually, since it dirties no
pages at all.

But there is no external trigger mechanism for this in Linux right now.


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPuw8U56oYWuOrkARAicaAJ9UlEjG79mSmEhYfYgrQHeKRayHcQCg33oZ
fxMdDl4zJ2eqkenp7oIFk0U=
=uZpu
-----END PGP SIGNATURE-----
