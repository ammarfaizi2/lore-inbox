Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129702AbQLBGBB>; Sat, 2 Dec 2000 01:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbQLBGAv>; Sat, 2 Dec 2000 01:00:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:62991 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129702AbQLBGAk>; Sat, 2 Dec 2000 01:00:40 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch-2.4.0-test12-pre3] microcode update for P4 (fwd)
Date: 1 Dec 2000 21:29:46 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <90a1ca$3rt$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0012011150490.877-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0012011150490.877-100000@penguin.homenet>
By author:    Tigran Aivazian <tigran@veritas.com>
In newsgroup: linux.dev.kernel
>
> Second attempt -- the first one got lost due to some local mail client
> problems...
> 
> Hi Linus,
> 
> Here is the patch to microcode update driver to support the new P4
> CPU.
> 
> --- linux/include/asm-i386/msr.h	Thu Oct  7 18:17:09 1999
> +++ ucode/include/asm-i386/msr.h	Fri Dec  1 09:38:59 2000
> @@ -30,3 +30,7 @@
>  			  : "=a" (low), "=d" (high) \
>  			  : "c" (counter))
>  
> +/* symbolic names for some interesting MSRs */
> +#define IA32_PLATFORM_ID	0x17
> +#define IA32_UCODE_WRITE	0x79
> +#define IA32_UCODE_REV		0x8B
> 

Please call these MSR_* instead, "IA32_*" isn't very descriptive,
besides, the preferred prefix in existing locations in the Linux
kernel is "X86_", e.g. X86_EFLAGS_IF or X86_CR4_PSE.  I think there
are standard symbolic names for most MSRs in volume 3 of the Intel
processor manuals; I would suggest we use those.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
