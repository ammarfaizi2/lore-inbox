Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316249AbSEJNUw>; Fri, 10 May 2002 09:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316250AbSEJNUv>; Fri, 10 May 2002 09:20:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27910 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316249AbSEJNUt>; Fri, 10 May 2002 09:20:49 -0400
Date: Fri, 10 May 2002 14:20:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.15 warnings
Message-ID: <20020510142038.A7165@flint.arm.linux.org.uk>
In-Reply-To: <26013.1021001169@kao2.melbourne.sgi.com> <26949.1021006885@kao2.melbourne.sgi.com> <15579.46584.447522.360378@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 01:58:48PM +0200, Mikael Pettersson wrote:
> This patch silences the sound/oss/emu10k1 warnings.

You probably want to think about these in context of 32bit vs 64bit
machines.

> --- linux-2.5.15/sound/oss/emu10k1/efxmgr.h.~1~	Wed Feb 20 03:11:02 2002
> +++ linux-2.5.15/sound/oss/emu10k1/efxmgr.h	Fri May 10 01:54:43 2002
> @@ -50,10 +50,10 @@
>          u16 code_start;
>          u16 code_size;
>  
> -        u32 gpr_used[NUM_GPRS / 32];
> -        u32 gpr_input[NUM_GPRS / 32];
> -        u32 route[NUM_OUTPUTS];
> -        u32 route_v[NUM_OUTPUTS];
> +        unsigned long gpr_used[NUM_GPRS / 32];
> +        unsigned long gpr_input[NUM_GPRS / 32];
> +        unsigned long route[NUM_OUTPUTS];
> +        unsigned long route_v[NUM_OUTPUTS];
>  };
>  
>  struct dsp_patch {
> @@ -64,8 +64,8 @@
>          u16 code_start;
>          u16 code_size;
>  
> -        u32 gpr_used[NUM_GPRS / 32];    /* bitmap of used gprs */
> -        u32 gpr_input[NUM_GPRS / 32];
> +        unsigned long gpr_used[NUM_GPRS / 32];    /* bitmap of used gprs */
> +        unsigned long gpr_input[NUM_GPRS / 32];
>          u8 traml_istart;  /* starting address of the internal tram lines used */
>          u8 traml_isize;   /* number of internal tram lines used */
>  

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

