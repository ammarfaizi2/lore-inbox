Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268606AbRGYSJb>; Wed, 25 Jul 2001 14:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268605AbRGYSJV>; Wed, 25 Jul 2001 14:09:21 -0400
Received: from daytona.gci.com ([205.140.80.57]:29962 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S268606AbRGYSJJ>;
	Wed, 25 Jul 2001 14:09:09 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315053E1265@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Subject: Sparc-64 kernel build fails on version.h during 'make oldconfig'
Date: Wed, 25 Jul 2001 09:39:46 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

When 'bootstrapping' a new kernel:

cp ../oldlinux/.config .
make oldconfig
make dep
...
/usr/src/linux/include/linux/udf_fs_sb.h:22: linux/version.h: No such file
or directory


For some reason, include/linux/version.h  is not being built for this
procedure, however:
cp ../oldlinux/.config .
make menuconfig
make dep

works perfectly.

changing the Makefile rule for oldconfig thusly:

	oldconfig: /include/linux/version.h symlinks

makes it nice and peachy.

Is there a reason that this is not done? ( also, xconfig, config are the
same as oldconfig....)



--
Leif Sawyer   --  Pi@4398680
leif@gci.net  ||  lsawyer@gci.com  ||  internic: LS2540 
(907) 868 - 0116   ||  ICQ - 3749190  || http://home.gci.net/~leif
Network & Security Engineer -- General Communication Inc.
PGP Fingerprint: 77 C8 34 B8 FD BC C6 32  5F FE 93 4B AE 6C F7 4E
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GAT d+ s: a C+++(++)$ US++++$ UL++++$ P+++ L++(+++) E---
W+++ N+ o+ K w O- M- V PS+ PE Y+ PGP(+) t+@ 5- X R- tv b++(+++)
DI++++ D++ G+ e(+)* h-- r++ y+ PP++++ HH++++ A19 NT{--}
------END GEEK CODE BLOCK------
Decode it! http://www.ebb.org/ungeek/



