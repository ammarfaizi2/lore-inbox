Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754360AbWKKKYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbWKKKYr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 05:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbWKKKYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 05:24:47 -0500
Received: from mx27.mail.ru ([194.67.23.64]:8456 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1753167AbWKKKYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 05:24:46 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc5: where can I select INPUT?
Date: Sat, 11 Nov 2006 13:24:58 +0300
User-Agent: KMail/1.9.5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111325.02749.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Neither in menuconfig nor in xconfig do I see any place to actually select 
INPUT. Help text suggests that it is a) selectable b) it can be made modules. 
I do not have either option. Here what I see in menuconfig if I go into Input 
device support:

    --- Generic input layer (needed for keyboard, mouse, ...)
    < >   Support for memoryless force-feedback devices
    ---   Userland interfaces

as you see there is no check box for INPUT itself.

I already had similar issue something else (I believe it was something related 
to serio). In menuconfig item was no selectable, but I could directly 
edit .config to change y to m.

This may be related to

  Symbol: INPUT [=y]
  Prompt: Generic input layer (needed for keyboard, mouse, ...)
    Defined at drivers/input/Kconfig:7
    Depends on: EMBEDDED
    Location:
      -> Device Drivers
        -> Input device support
    Selected by: VT

and CONFIG_VT is indeed y (I do not think this even can ever be m). Still even 
then this is way too confusing.
.config can be provided on request

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVaT+R6LMutpd94wRAlwlAJ9RduOcCi3u00p/BsY/GoP2Xs4IgACfV6lp
YqEaBKJ1DY5OK5TIEsH2iP4=
=kBNh
-----END PGP SIGNATURE-----
