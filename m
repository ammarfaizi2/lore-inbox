Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283618AbRLIQwz>; Sun, 9 Dec 2001 11:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283621AbRLIQwq>; Sun, 9 Dec 2001 11:52:46 -0500
Received: from smtp02.web.de ([217.72.192.151]:12554 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S283618AbRLIQwg>;
	Sun, 9 Dec 2001 11:52:36 -0500
Date: Sun, 9 Dec 2001 17:52:21 +0100
From: Richard Hoechenberger <GeekuX@web.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.1-pre8 doesn't compile w/ LVM support
Message-ID: <20011209175221.A19993@web.de>
Reply-To: Richard Hoechenberger <GeekuX@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.9-ac10 i686
X-Editor: VIM - Vi IMproved 5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just downloaded the 2.5.0 kernel and patched it up to 2.5.1-pre8.
When I try to compile (using 'make-kpkg' v1.65 under Debian), I get the
following error:

make[3]: Entering directory `/tmp/kernel/linux/drivers/md'
/usr/bin/make all_targets
make[4]: Entering directory `/tmp/kernel/linux/drivers/md'
gcc -D__KERNEL__ -I/tmp/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o lvm.o lvm.c
lvm.c: In function `lvm_user_bmap':
lvm.c:1046: request for member `bv_len' in something not a structure or union
make[4]: *** [lvm.o] Fehler 1
make[4]: Leaving directory `/tmp/kernel/linux/drivers/md'
make[3]: *** [first_rule] Fehler 2
make[3]: Leaving directory `/tmp/kernel/linux/drivers/md'
make[2]: *** [_subdir_md] Fehler 2
make[2]: Leaving directory `/tmp/kernel/linux/drivers'
make[1]: *** [_dir_drivers] Fehler 2
make[1]: Leaving directory `/tmp/kernel/linux'
make: *** [stamp-build] Fehler 2
richard@sid:/tmp/kernel/linux$


In my .config, CONFIG_BLK_DEV_LVM is set to 'y'.

I'm using gcc version 2.95.4, running on Linux 2.4.9-ac10.


Any idea what's causing the problem?


Richard
