Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbTAQPoq>; Fri, 17 Jan 2003 10:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbTAQPop>; Fri, 17 Jan 2003 10:44:45 -0500
Received: from franka.aracnet.com ([216.99.193.44]:57063 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267532AbTAQPoo>; Fri, 17 Jan 2003 10:44:44 -0500
Date: Fri, 17 Jan 2003 07:53:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: MAX_IO_APICS #ifdef'd wrongly
Message-ID: <224570000.1042818820@titus>
In-Reply-To: <20030117090031.GD940@holomorphy.com>
References: <20030117090031.GD940@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summit needs this too, so it should really be CONFIG_NUMA at least.
Ideally this would go into subarch if we can move it cleanly (hint, hint ;-))
But other than that, yes ... I'll merge it.

Thanks,

M.

--On Friday, January 17, 2003 01:00:31 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:

> CONFIG_X86_NUMA no longer exists. This changes the MAX_IO_APICS
> definition to 32, where it is required to be so large on NUMA-Q
> in order to boot.
> 
> 
> diff -urpN linux-2.5.59/include/asm-i386/apicdef.h ioapic-2.5.59/include/asm-i386/apicdef.h
> --- linux-2.5.59/include/asm-i386/apicdef.h	2003-01-16 18:22:15.000000000 -0800
> +++ ioapic-2.5.59/include/asm-i386/apicdef.h	2003-01-17 00:58:04.000000000 -0800
> @@ -115,7 +115,7 @@
>  
>  #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
>  
> -#ifdef CONFIG_X86_NUMA
> +#ifdef CONFIG_X86_NUMAQ
>   #define MAX_IO_APICS 32
>  #else
>   #define MAX_IO_APICS 8
> 
> 


