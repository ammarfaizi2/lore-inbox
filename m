Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVIOGSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVIOGSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOGSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:18:16 -0400
Received: from h80ad2507.async.vt.edu ([128.173.37.7]:31362 "EHLO
	h80ad2507.async.vt.edu") by vger.kernel.org with ESMTP
	id S932527AbVIOGSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:18:15 -0400
Message-Id: <200509150618.j8F6I9ji020578@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: marekw1977@yahoo.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel 
In-Reply-To: Your message of "Thu, 15 Sep 2005 14:18:13 +1000."
             <200509151418.13927.marekw1977@yahoo.com.au> 
From: Valdis.Kletnieks@vt.edu
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz> <1126753444.13893.123.camel@mindpipe>
            <200509151418.13927.marekw1977@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126765087_2866P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Sep 2005 02:18:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126765087_2866P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Sep 2005 14:18:13 +1000, Marek W said:

> Not so much the kernel. When compiling the kernel I'd prefer not to waste time 
> and space compiling the 100+ modules I will never ever use on my laptop.

It's actually  a lot worse than that - here's my minimized custom kernel that
drives everything on my laptop and then some, and a recent Fedora kernel:

[/lib/modules]2 find 2.6.13-mm1/kernel/drivers -name '*.ko' | wc -l
37
[/lib/modules]2 find 2.6.12-1.1400_FC5/kernel/drivers/ -name '*.ko' | wc -l
832

(OK, so I *do* have a few builtins that Fedora builds as modules. That's gonna
change the numbers by half a dozen or so...)

>                                                                          I'd
> prefer for something to select the modules necessary for my hardware. I can't 
> afford the time to keep up to date with that's new and what isn't, what has 
> changed, what has been superseded, which module works with which device, 
> chipset even, etc...

I'm of the opinion that if you don't have that much time, you should be using a
distro kernel where somebody *else* is taking the time.  If you're the type
that builds their own kernel, the *last* thing you want is a tool glossing over
the fact that a module has been superceded.  Who's going to take care of the
matching changes for /etc/modprobe.conf and similar userspace changes, and
other stuff like that? (I figure if 'make oldconfig' asks a question, I should
take notice, and any userspace changes that don't get made are my fault - and
if 'make oldconfig' switches drivers on me without asking, that's a *bug* that
lkml will hear about.. ;)


--==_Exmh_1126765087_2866P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDKRIfcC3lWbTT17ARAgXxAKDyXM+/cftAA/LlPaIFlufW3eS2ygCfZHyZ
LbxW36CbqV/RP6H1OxMLHDM=
=Szi1
-----END PGP SIGNATURE-----

--==_Exmh_1126765087_2866P--
