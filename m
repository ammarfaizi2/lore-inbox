Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbUAKAAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUAKAAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:00:39 -0500
Received: from [200.57.38.4] ([200.57.38.4]:44455 "EHLO gateway.mailvault.com")
	by vger.kernel.org with ESMTP id S265675AbUAKAAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:00:35 -0500
Date: Sun, 11 Jan 2004 01:00:33 00100 (CET)
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
From: "Job 317" <job317@mailvault.com>
Subject: HELP!! 2.6.x build problem with make xconfig
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary = "=_f08c0a35b5c1b72911b4ea5809f6edbf"
Message-Id: <20040110235440.7962B8400A3@gateway.mailvault.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encoded message.

--=_f08c0a35b5c1b72911b4ea5809f6edbf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Please don't flame me for missing this if it's already buried in the
archive but I cannot make xconfig, gconfig, or menuconfig with a 2.6.X
kernel.

I am using RH 9.0 with all up2dates (including required packages for
2.6.x kernel build as far as I can tell). Am I missing a symbolic link
or something?

Here's what I do (as root)...

cd /usr/src
rm linux linux-2.4 linux-2.6
tar -zxvf linux-2.6.x.tar.gz
chown -R 0.0 linux-2.6.x
ln -fs linux-2.6.x linux
ln -fs linux-2.4.x linux-2.6    # not sure why I do this anymore
cd /usr/include
rm asm linux scsi
ln -fs /usr/src/linux/include/asm-i386 asm
ln -fs /usr/src/linux/include/linux linux
ln -fs /usr/src/linux/include/scsi scsi
cd /usr/src/linux-2.6.x
make mrproper xconfig

<!-- My error follows -->

In file included from /usr/include/linux/errno.h:4,
                 from /usr/include/bits/errno.h:25,
                 from /usr/include/errno.h:36,
                 from scripts/kconfig/mconf.c:12:
/usr/include/asm/errno.h:4:31: asm-generic/errno.h: No such file or
directory
scripts/kconfig/mconf.c: In function `exec_conf':
scripts/kconfig/mconf.c:243: `EINTR' undeclared (first use in this
function)
scripts/kconfig/mconf.c:243: (Each undeclared identifier is reported
only once
scripts/kconfig/mconf.c:243: for each function it appears in.)
scripts/kconfig/mconf.c:243: `EAGAIN' undeclared (first use in this
function)
make[1]: *** [scripts/kconfig/mconf.o] Error 1
make: *** [xconfig] Error 2

<!-- If I do a make gconfig, I get the following -->

In file included from /usr/include/gtk-2.0/gtk/gtk.h:90,
                 from scripts/kconfig/gconf.c:17:
/usr/include/gtk-2.0/gtk/gtkitemfactory.h:51: warning: function
declaration isn't a prototype
scripts/kconfig/images.c:6: warning: `xpm_load' defined but not used
scripts/kconfig/images.c:36: warning: `xpm_save' defined but not used
scripts/kconfig/images.c:66: warning: `xpm_back' defined but not used
scripts/kconfig/images.c:175: warning: `xpm_symbol_no' defined but not
used
scripts/kconfig/images.c:192: warning: `xpm_symbol_mod' defined but not
used
scripts/kconfig/images.c:209: warning: `xpm_symbol_yes' defined but not
used
scripts/kconfig/images.c:226: warning: `xpm_choice_no' defined but not
used
scripts/kconfig/images.c:243: warning: `xpm_choice_yes' defined but not
used
scripts/kconfig/images.c:277: warning: `xpm_menu_inv' defined but not
used
scripts/kconfig/images.c:294: warning: `xpm_menuback' defined but not
used
scripts/kconfig/gconf.c:981: warning: `renderer_toggled' defined but not
used
In file included from /usr/include/linux/errno.h:4,
                 from /usr/include/bits/errno.h:25,
                 from /usr/include/errno.h:36,
                 from scripts/kconfig/mconf.c:12:
/usr/include/asm/errno.h:4:31: asm-generic/errno.h: No such file or
directory
scripts/kconfig/mconf.c: In function `exec_conf':
scripts/kconfig/mconf.c:243: `EINTR' undeclared (first use in this
function)
scripts/kconfig/mconf.c:243: (Each undeclared identifier is reported
only once
scripts/kconfig/mconf.c:243: for each function it appears in.)
scripts/kconfig/mconf.c:243: `EAGAIN' undeclared (first use in this
function)
make[1]: *** [scripts/kconfig/mconf.o] Error 1
make: *** [gconfig] Error 2

Please help or point me to a FAW or something...

Thanks

JOB

--=_f08c0a35b5c1b72911b4ea5809f6edbf--


