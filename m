Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbSLNJat>; Sat, 14 Dec 2002 04:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbSLNJat>; Sat, 14 Dec 2002 04:30:49 -0500
Received: from holomorphy.com ([66.224.33.161]:15790 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267535AbSLNJar>;
	Sat, 14 Dec 2002 04:30:47 -0500
Date: Sat, 14 Dec 2002 01:38:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: mdew <mdew@orcon.net.nz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: rmap and nvidia?
Message-ID: <20021214093831.GL9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mdew <mdew@orcon.net.nz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1039858571.559.15.camel@nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039858571.559.15.camel@nirvana>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 10:36:10PM +1300, mdew wrote:
> is there a nvidia patch available to make it work with rmap?
> 
> nirvana:~/NVIDIA_kernel-1.0-3123# make
> echo \#define NV_COMPILER \"`cc -v 2>&1 | tail -1`\" > nv_compiler.h
> cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
> -Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
> -D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -DNTRM -D_GNU_SOURCE
> -DRM_HEAPMGR -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE 
> -DNV_MAJOR_VERSION=1 -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=3123 
> -DNV_UNIX   -DNV_LINUX   -DNVCPU_X86       -I.
> -I/lib/modules/2.4.20-xfs-rmap15b/build/include -Wno-cast-qual nv.c
> nv.c: In function `nv_get_phys_address':
> nv.c:2182: warning: implicit declaration of function `pte_offset'
> nv.c:2182: invalid type argument of `unary *'
> make: *** [nv.o] Error 1

Use pte_offset_map() with a corresponding pte_unmap().


Bill
