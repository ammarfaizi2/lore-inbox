Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVAWBuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVAWBuC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 20:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVAWBuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 20:50:01 -0500
Received: from brn35.neoplus.adsl.tpnet.pl ([83.29.107.35]:42289 "EHLO
	thinkpaddie") by vger.kernel.org with ESMTP id S261183AbVAWBtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 20:49:52 -0500
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Organization: K4
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: can't compile 2.6.11-rc2 on sparc64
Date: Sun, 23 Jan 2005 02:48:26 +0100
User-Agent: KMail/1.7.91
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200501230238.55584@gj-laptop> <41F2FFBB.7020300@osdl.org>
In-Reply-To: <41F2FFBB.7020300@osdl.org>
X-Face: ?m}EMc-C]"l7<^`)a1NYO-(=?utf-8?q?=27xy3=3A5V=7B82Z=5E-/D3=5E=5BMU8IHkf=24o=60=7E=25CC5D4=5BGhaIgk?=
 =?utf-8?q?/=24oN7=0A=09Y7=3Bf=7D!?=(<IG>ooAGiKCVs$m~P1B-8Vt=]<V,FX{h4@fK/?Qtg]5ofD|P~&)q:6H>
 =?utf-8?q?=7E1Nt2fh=0A=09s-iKbN=24=2ENe=5E1?=(4tdwmmW>ew'=LPv+{{=YE=LoZU-5kfYnZSa`P7Q4pW]tKmUk`@&}M,
 =?utf-8?q?dn-=0A=09Kh=7BhA=7B=7ELs4a=24NjJI?=@1_f')]3|_}!GoJZss[Q$D-#l^.4GxPp[p:s<S~B&+6)
gj-laptop: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501230248.27332@gj-laptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 January 2005 02:36, Randy.Dunlap wrote:

> Please look for another error.  Run 'make' again.
> Those are all just warnings and don't cause a build error.

all output past make:

[root@gjsparc64 linux-2.6.11-rc2]# make V=1
if test ! /usr/src/linux-2.6.11-rc2 -ef /usr/src/linux-2.6.11-rc2; then \
/bin/bash /usr/src/linux-2.6.11-rc2/scripts/mkmakefile              \
    /usr/src/linux-2.6.11-rc2 /usr/src/linux-2.6.11-rc2 2 6         \
    > /usr/src/linux-2.6.11-rc2/Makefile;                                 \
    echo '  GEN    /usr/src/linux-2.6.11-rc2/Makefile';                   \
fi
  CHK     include/linux/version.h
rm -rf .tmp_versions
mkdir -p .tmp_versions
make -f scripts/Makefile.build obj=scripts/basic
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/genksyms
make -f scripts/Makefile.build obj=scripts/mod
make -f scripts/Makefile.build obj=init
  CHK     include/linux/compile.h
make -f scripts/Makefile.build obj=usr
set -e; echo '  CHK     usr/initramfs_list'; mkdir -p 
usr/; /bin/bash /usr/src/linux-2.6.11-rc2/scripts/gen_initramfs_list.sh    > 
usr/initramfs_list.tmp; if [ -r usr/initramfs_list ] && cmp -s 
usr/initramfs_list usr/initramfs_list.tmp; then rm -f usr/initramfs_list.tmp; 
else echo '  UPD     usr/initramfs_list'; mv -f usr/initramfs_list.tmp 
usr/initramfs_list; fi
  CHK     usr/initramfs_list
make -f scripts/Makefile.build obj=arch/sparc64/kernel
  /usr/bin/sparc64-pld-linux-gcc -Wp,-MD,arch/sparc64/kernel/.ioctl32.o.d 
-nostdinc -isystem /usr/lib/gcc/sparc64-pld-linux/3.4.2/include -D__KERNEL__ 
-Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -ffreestanding -O2     -fomit-frame-pointer -m64 -pipe -mno-fpu 
-mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 
-Wno-sign-compare -Wa,--undeclared-regs -finline-limit=100000 
-Wdeclaration-after-statement  -Werror -Ifs/  -DKBUILD_BASENAME=ioctl32 
-DKBUILD_MODNAME=ioctl32 -c -o arch/sparc64/kernel/.tmp_ioctl32.o 
arch/sparc64/kernel/ioctl32.c
include/asm/uaccess.h: In function `siocdevprivate_ioctl':
fs/compat_ioctl.c:648: warning: ignoring return value of `copy_to_user', 
declared with attribute warn_unused_result
fs/compat_ioctl.c: In function `put_dirent32':
fs/compat_ioctl.c:2346: warning: ignoring return value of `copy_to_user', 
declared with attribute warn_unused_result
fs/compat_ioctl.c: In function `serial_struct_ioctl':
fs/compat_ioctl.c:2489: warning: ignoring return value of `copy_from_user', 
declared with attribute warn_unused_result
fs/compat_ioctl.c:2502: warning: ignoring return value of `copy_to_user', 
declared with attribute warn_unused_result
make[1]: *** [arch/sparc64/kernel/ioctl32.o] Error 1
make: *** [arch/sparc64/kernel] Error 2
[root@gjsparc64 linux-2.6.11-rc2]#

I have no idea what causes error here. What shall I input to get more info 
about that error ?
                                       
-- 
GJ
