Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317260AbSGCVqn>; Wed, 3 Jul 2002 17:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSGCVqm>; Wed, 3 Jul 2002 17:46:42 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:12219 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317260AbSGCVqk>; Wed, 3 Jul 2002 17:46:40 -0400
Date: Wed, 3 Jul 2002 23:47:58 +0200
From: Ulrich Wiederhold <U.Wiederhold@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: nvidia driver won't compile with 2.4.19-rc1
Message-ID: <20020703214757.GA504@sky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux 3.0 (Kernel 2.4.19-rc1)
Organization: Using Linux Only
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
if I make an update-modules, I get:
depmod: *** Unresolved symbols in
/lib/modules/2.4.19-rc1/kernel/drivers/scsi/sr_mod.o

and if I wanna compile "NVIDIA_kernel-1.0-2880":

home:/NVIDIA_kernel-1.0-2880# make
cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
-Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -D_X86=1 -Di386=1 -DUNIX
-DLINUX -DNV4_HW -DNTRM -DRM20 -D_GNU_SOURCE -DRM_HEAPMGR
-D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1
-DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2880   -I.
-I/lib/modules/2.4.19-rc1/build/include -Wno-cast-qual nv.c
cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
-Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -D_X86=1 -Di386=1 -DUNIX
-DLINUX -DNV4_HW -DNTRM -DRM20 -D_GNU_SOURCE -DRM_HEAPMGR
-D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1
-DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2880   -I.
-I/lib/modules/2.4.19-rc1/build/include -Wno-cast-qual os-interface.c
os-interface.c:1207: warning: `wb_list' defined but not used
cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
-Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -D_X86=1 -Di386=1 -DUNIX
-DLINUX -DNV4_HW -DNTRM -DRM20 -D_GNU_SOURCE -DRM_HEAPMGR
-D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1
-DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2880   -I.
-I/lib/modules/2.4.19-rc1/build/include -Wno-cast-qual os-registry.c
ld -r -o Module-linux nv.o os-interface.o os-registry.o 
ld -r -o NVdriver Module-linux Module-nvkernel
size NVdriver
   text    data     bss     dec     hex filename
    779245   52020   52364  883629   d7bad NVdriver
    depmod: *** Unresolved symbols in
    /lib/modules/2.4.19-rc1/kernel/drivers/scsi/sr_mod.o
    make: *** [package-install] Fehler 1
    home:/home/fzzgrr/NVIDIA_kernel-1.0-2880# update-modules 
    depmod: *** Unresolved symbols in
    /lib/modules/2.4.19-rc1/kernel/drivers/scsi/sr_mod.o

I get the same error. I had no problems compiling them with 2.4.17-rc2.
Any ideas what to do?

Uli

-- 
'The box said, 'Requires Windows 95 or better', so i installed Linux - TKK 5
