Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUI2OsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUI2OsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUI2OpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:45:16 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:7317 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S268505AbUI2Olj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:41:39 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: sboyce@blueyonder.co.uk
Subject: Re: 2.6.9-rc2-mm4 and nvidia 1.0-6111
Date: Wed, 29 Sep 2004 07:41:44 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <415A6EE6.1090404@blueyonder.co.uk>
In-Reply-To: <415A6EE6.1090404@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409290741.45825.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a known issue and it's releated to some changes in Andrew's tree. Not 
to sound pesimistic but in the future expect the nvidia drivers to be broken 
for the -mm tree, it is after an the expiremental kernel tree. 

matt 

On Wednesday 29 September 2004 1:14 am, Sid Boyce wrote:
> The usual patches applied that made it work with -mm3.
> Changed all instances of NV_REMAP_PAGE_RANGE to NV_REMAP_PFN_RANGE and
> nv_remap_page_range to nv_remap_pfn_range in nv.c, nv-linux.h,
> os-agp.c and os-interface.c as redifined in
> /usr/src/linux-2.6.9-rc2-mm4/include/linux/mm.h.
> The module builds and installs without problems, but on init 5, I get
> thrown back to vt1, /var/log/XFree86.0.log gives the error:-
> (--) NVIDIA(0): Linear framebuffer at 0xD8000000
> (--) NVIDIA(0): MMIO registers at 0xE1000000
> (II) NVIDIA(0): NVIDIA GPU detected as: GeForce FX 5200
> (--) NVIDIA(0): VideoBIOS: 04.34.20.42.01
> (--) NVIDIA(0): Interlaced video modes are supported on this GPU
> (II) NVIDIA(0): Detected AGP rate: 8X
> (EE) NVIDIA(0): Failed to allocate config DMA context
> (II) UnloadModule: "nvidia"
> (II) UnloadModule: "vgahw"
> (II) Unloading /usr/X11R6/lib/modules/libvgahw.a
> (EE) Screen(s) found, but none have a usable configuration.
>
> Fatal server error:
> no screens found
> -------------------------------
> Any help appreciated, also posted to nvidia forum.
>
> Regards
> Sid.
