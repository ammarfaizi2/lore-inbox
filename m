Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbUKHOAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbUKHOAC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUKHOAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:00:02 -0500
Received: from europa.telenet-ops.be ([195.130.132.60]:36752 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261840AbUKHN7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 08:59:42 -0500
From: Bart Verwilst <bart@dct-mail.com>
To: linux-kernel@vger.kernel.org
Subject: ata_piix slow in 2.4.27?
Date: Mon, 8 Nov 2004 14:59:38 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411081459.38914.bart@dct-mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to setup a Dell Poweredge machine, but i'm getting very low 
throughput on the ata_piix drivers, of approx. 4 MB per second.. I tried 
downloading and compiling the drivers that Dell provides ( for RHEL3, even if 
this machine isn't a redhat.. ) But it fails to compile with this error:

00E0816194A8 0.93c # cat /var/dkms/ata_piix/1.00b/build/make.log
DKMS make.log for ata_piix-1.00b for kernel 2.4.27-DCT
Mon Nov  8 14:44:25 CET 2004
make: Entering directory `/usr/src/linux-2.4.27'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o 
scripts/split-include scripts/split-include.c
scripts/split-include include/linux/autoconf.h include/config
make -C  /var/dkms/ata_piix/1.00b/build CFLAGS="-D__KERNEL__ 
-I/usr/src/linux-2.4.27/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe 
-mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS 
-include /usr/src/linux-2.4.27/include/linux/modversions.h" MAKING_MODULES=1 
modules
make[1]: Entering directory `/var/dkms/ata_piix/1.00b/build'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.27/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
-pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS 
-include /usr/src/linux-2.4.27/include/linux/modversions.h  -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=ata_piix  -c -o ata_piix.o ata_piix.c
ata_piix.c:128: unknown field `phy_config' specified in initializer
ata_piix.c:128: `pata_phy_config' undeclared here (not in a function)
ata_piix.c:128: initializer element is not constant
ata_piix.c:128: (near initialization for `piix_pata_ops.post_set_mode')
ata_piix.c:151: unknown field `phy_config' specified in initializer
ata_piix.c:151: `pata_phy_config' undeclared here (not in a function)
ata_piix.c:151: initializer element is not constant
ata_piix.c:151: (near initialization for `piix_sata_ops.post_set_mode')
make[1]: *** [ata_piix.o] Error 1
make[1]: Leaving directory `/var/dkms/ata_piix/1.00b/build'
make: *** [_mod_/var/dkms/ata_piix/1.00b/build] Error 2
make: Leaving directory `/usr/src/linux-2.4.27'



Does anybody know why the driver is so slow in .27? Maybe somebody has some 
patches available to fix this? :)


Could it be possible to CC me too, since i'm not on this mailinglist...

Thanks in advance!

--
Bart Verwilst
Platforms Engineer
DataCenter Technologies
