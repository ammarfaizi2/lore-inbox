Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVAQFu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVAQFu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 00:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVAQFu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 00:50:56 -0500
Received: from ns.suse.de ([195.135.220.2]:42156 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262704AbVAQFut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 00:50:49 -0500
Date: Mon, 17 Jan 2005 06:50:40 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x86_64: kill stale mtrr_centaur_report_mcr
Message-ID: <20050117055040.GE19187@wotan.suse.de>
References: <20050116074817.GX4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116074817.GX4274@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 08:48:17AM +0100, Adrian Bunk wrote:
> I didn't know the x86_64 port supports the Centaur CPU.  ;-)

Have you actually compiled this? Most of the gunk in asm-x86_64/mtrr.h
is because we share the MTRR driver with i386, and there is no good
way to disable specific CPUs in there.


-Andi



> 
> 
> diffstat output:
>  include/asm-x86_64/mtrr.h |    3 ---
>  1 files changed, 3 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.11-rc1-mm1-full/include/asm-x86_64/mtrr.h.old	2005-01-16 04:27:41.000000000 +0100
> +++ linux-2.6.11-rc1-mm1-full/include/asm-x86_64/mtrr.h	2005-01-16 04:27:54.000000000 +0100
> @@ -79,7 +79,6 @@
>  		     unsigned int type, char increment);
>  extern int mtrr_del (int reg, unsigned long base, unsigned long size);
>  extern int mtrr_del_page (int reg, unsigned long base, unsigned long size);
> -extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
>  #  else
>  static __inline__ int mtrr_add (unsigned long base, unsigned long size,
>  				unsigned int type, char increment)
> @@ -102,8 +101,6 @@
>      return -ENODEV;
>  }
>  
> -static __inline__ void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi) {}
> -
>  #  endif
>  
>  #endif
> 
