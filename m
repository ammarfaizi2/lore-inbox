Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUFUJxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUFUJxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 05:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUFUJxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 05:53:09 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.78]:7747 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S266176AbUFUJxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 05:53:05 -0400
Date: Mon, 21 Jun 2004 05:52:51 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: 2.6.7-bk way too fast
In-reply-to: <Pine.LNX.4.58.0406210031160.11274@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Clemens Schwaighofer <cs@tequila.co.jp>,
       "Matt H." <lkml@lpbproductions.com>,
       Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Message-id: <200406210552.57420.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <40D64DF7.5040601@pobox.com> <40D688D1.7020308@tequila.co.jp>
 <Pine.LNX.4.58.0406210031160.11274@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 21 June 2004 03:37, Linus Torvalds wrote:
> Ok, either we have two bugs with _exactly_ the same behaviour, or
> something is just getting screwed up. That single change has definitely
> been fingered as being the problem by a few people. And removing the one
> line (if you have an x86-64 system you have to remove it in the x86-64
> version of the file too) should undo the patch that seems to have caused
> the problem in the first place.
>
> Anyway, my one-liner patch won't have applied at all if you had applied
> Andrew's patch, so the first thing to do is to double-check that it
> actually got applied. I'm still hoping. But assuming it did, can you
> enable APIC debugging in include/asm-i386/apic.h, and send the resulting
> honking huge dmesg to me and the other suspects in this on-going saga?
>
> Preferably both from a plain 2.6.7 kernel (well, "plain" except for the
> DEBUG enable) and from the broken kernel..

If you want the dmesgs, you can get them from 
http://shells.gnugeneration.com/~jeffpc/kernel/logs/.

The 'bad' one is before your patch, and the 'good' one is after your patch.

Jeff.

- -- 
We have joy, we have fun, we have Linux on a Sun...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1q/3wFP0+seVj/4RAmX8AJ9w/O8ZPFL0LuH/fqoA8nYBbpMBsQCfWe1N
U8WsaVMhFsT2og5BxmS6fjk=
=E2nb
-----END PGP SIGNATURE-----
