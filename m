Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269035AbUHYAsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269035AbUHYAsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269041AbUHYAsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:48:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52926 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269043AbUHYArp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:47:45 -0400
Message-ID: <412BE1A7.1080407@pobox.com>
Date: Tue, 24 Aug 2004 20:47:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pluto@pld-linux.org, akpm@osdl.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ix86,x86_64 cpu features
References: <200408242233.i7OMXrTd001684@hera.kernel.org>
In-Reply-To: <200408242233.i7OMXrTd001684@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff -Nru a/include/asm-x86_64/cpufeature.h b/include/asm-x86_64/cpufeature.h
> --- a/include/asm-x86_64/cpufeature.h	2004-08-24 15:34:02 -07:00
> +++ b/include/asm-x86_64/cpufeature.h	2004-08-24 15:34:02 -07:00
> @@ -63,8 +63,14 @@
>  #define X86_FEATURE_K8_C	(3*32+ 4) /* C stepping K8 */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
> -#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
> +#define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
>  #define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
> +#define X86_FEATURE_DSCPL	(4*32+ 4) /* CPL Qualified Debug Store */
> +#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
> +#define X86_FEATURE_TM2		(4*32+ 8) /* Thermal Monitor 2 */
> +#define X86_FEATURE_CID		(4*32+10) /* Context ID */
> +#define X86_FEATURE_CX16	(4*32+13) /* CMPXCHG16B */
> +#define X86_FEATURE_XTPR	(4*32+14) /* Send Task Priority Messages */


FYI, the style for cpufeature.h is to _not_ add constants for a feature 
bit unless that feature is actually used.

	Jeff, one of the people who last touched this area of code


