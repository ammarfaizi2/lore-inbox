Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSGCWVq>; Wed, 3 Jul 2002 18:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317301AbSGCWVp>; Wed, 3 Jul 2002 18:21:45 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:52104 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S317300AbSGCWVn>;
	Wed, 3 Jul 2002 18:21:43 -0400
Date: Thu, 4 Jul 2002 00:24:13 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Ulrich Wiederhold <U.Wiederhold@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: nvidia driver won't compile with 2.4.19-rc1
In-Reply-To: <20020703214757.GA504@sky.net>
Message-ID: <Pine.GSO.4.30.0207040023140.23914-200000@balu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1025735053=:23914"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-959030623-1025735053=:23914
Content-Type: TEXT/PLAIN; charset=US-ASCII


actually it compiles but the 'make' fails because of depmod complaining.

attached patch will help you.

On Wed, 3 Jul 2002, Ulrich Wiederhold wrote:

> Hello,
> if I make an update-modules, I get:
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.19-rc1/kernel/drivers/scsi/sr_mod.o
>
> and if I wanna compile "NVIDIA_kernel-1.0-2880":
>
> home:/NVIDIA_kernel-1.0-2880# make
> cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
> -Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
> -D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -D_X86=1 -Di386=1 -DUNIX
> -DLINUX -DNV4_HW -DNTRM -DRM20 -D_GNU_SOURCE -DRM_HEAPMGR
> -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1
> -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2880   -I.
> -I/lib/modules/2.4.19-rc1/build/include -Wno-cast-qual nv.c
> cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
> -Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
> -D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -D_X86=1 -Di386=1 -DUNIX
> -DLINUX -DNV4_HW -DNTRM -DRM20 -D_GNU_SOURCE -DRM_HEAPMGR
> -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1
> -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2880   -I.
> -I/lib/modules/2.4.19-rc1/build/include -Wno-cast-qual os-interface.c
> os-interface.c:1207: warning: `wb_list' defined but not used
> cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
> -Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
> -D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -D_X86=1 -Di386=1 -DUNIX
> -DLINUX -DNV4_HW -DNTRM -DRM20 -D_GNU_SOURCE -DRM_HEAPMGR
> -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE  -DNV_MAJOR_VERSION=1
> -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=2880   -I.
> -I/lib/modules/2.4.19-rc1/build/include -Wno-cast-qual os-registry.c
> ld -r -o Module-linux nv.o os-interface.o os-registry.o
> ld -r -o NVdriver Module-linux Module-nvkernel
> size NVdriver
>    text    data     bss     dec     hex filename
>     779245   52020   52364  883629   d7bad NVdriver
>     depmod: *** Unresolved symbols in
>     /lib/modules/2.4.19-rc1/kernel/drivers/scsi/sr_mod.o
>     make: *** [package-install] Fehler 1
>     home:/home/fzzgrr/NVIDIA_kernel-1.0-2880# update-modules
>     depmod: *** Unresolved symbols in
>     /lib/modules/2.4.19-rc1/kernel/drivers/scsi/sr_mod.o
>
> I get the same error. I had no problems compiling them with 2.4.17-rc2.
> Any ideas what to do?
>
> Uli
>
> --
> 'The box said, 'Requires Windows 95 or better', so i installed Linux - TKK 5
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
pozsy

---559023410-959030623-1025735053=:23914
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=nvidia-dont-complain
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.30.0207040024130.23914@balu>
Content-Description: 
Content-Disposition: attachment; filename=nvidia-dont-complain

LS0tIE5WSURJQV9rZXJuZWwtMS4wLTI5NjAvTWFrZWZpbGUub3JpZwlUdWUg
TWF5IDE0IDE1OjI2OjE1IDIwMDINCisrKyBOVklESUFfa2VybmVsLTEuMC0y
OTYwL01ha2VmaWxlCVdlZCBKdWwgIDMgMjM6Mjc6NTkgMjAwMg0KQEAgLTg1
LDcgKzg1LDcgQEANCiAJCWZpICYmIFwNCiAJCW1rZGlyIC1wICQoSU5TVEFM
TERJUikgJiYgXA0KIAkJJChJTlNUQUxMKSAtbSAwNjY0IC1vIHJvb3QgLWcg
cm9vdCBOVmRyaXZlciAkKElOU1RBTExESVIpL05WZHJpdmVyJChPKSAmJiBc
DQotCQkvc2Jpbi9kZXBtb2QgLWEgJiYgXA0KKwkJL3NiaW4vZGVwbW9kIC1h
cSAmJiBcDQogCQkvc2Jpbi9tb2Rwcm9iZSBOVmRyaXZlciAmJiBcDQogCQlz
aCBtYWtlZGV2aWNlcy5zaCAmJiBcDQogCQllY2hvICJOVmRyaXZlciBpbnN0
YWxsZWQgc3VjY2Vzc2Z1bGx5LiI7IFwNCg==
---559023410-959030623-1025735053=:23914--
