Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289708AbSAJVuh>; Thu, 10 Jan 2002 16:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289703AbSAJVu2>; Thu, 10 Jan 2002 16:50:28 -0500
Received: from zeus.kernel.org ([204.152.189.113]:39134 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289708AbSAJVt5>;
	Thu, 10 Jan 2002 16:49:57 -0500
Date: Thu, 10 Jan 2002 18:31:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Tony Glader <Tony.Glader@blueberrysolutions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 Kernel Oops
In-Reply-To: <Pine.LNX.4.33.0201101419280.3939-100000@blueberrysolutions.com>
Message-ID: <Pine.LNX.4.21.0201101831200.22287-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like memory corruption... 

Mind running memtest86 ? 

On Thu, 10 Jan 2002, Tony Glader wrote:

> 
> I'm running Kernel 2.4.17 in a classic Pentium 75MHz and I have problems 
> with it (with 2.2 series it works fine). After a while from boot I get lot 
> of kernel oops like this (if I have big load oops's will come more often):
> 
> --- 8< ---
> Jan  9 17:23:34 firewall kernel: Unable to handle kernel paging request at 
> virtual address 00001200
> Jan  9 17:23:34 firewall kernel:  printing eip:
> Jan  9 17:23:34 firewall kernel: 00001200
> Jan  9 17:23:34 firewall kernel: *pde = 00000000
> Jan  9 17:23:34 firewall kernel: Oops: 0000
> Jan  9 17:23:34 firewall kernel: CPU:    0
> Jan  9 17:23:34 firewall kernel: EIP:    0010:[<00001200>]    Not tainted
> Jan  9 17:23:34 firewall kernel: EFLAGS: 00013202
> Jan  9 17:23:34 firewall kernel: eax: 00000001   ebx: c024ce60   ecx: 
> c380b000   edx: 00000012
> Jan  9 17:23:34 firewall kernel: esi: 00000012   edi: 00000018   ebp: 
> 00000361   esp: c11f7f28
> Jan  9 17:23:34 firewall kernel: ds: 0018   es: 0018   ss: 0018
> Jan  9 17:23:34 firewall kernel: Process kswapd (pid: 4, 
> stackpage=c11f7000)
> Jan  9 17:23:34 firewall kernel: Stack: c109eec0 c0126983 c024ce60 
> 00000197 c11f6000 00000051 000001d0 c01fd4c8 
> Jan  9 17:23:34 firewall kernel:        c0265ee0 c11e35a0 c10c7590 
> 00000000 00000020 000001d0 00000006 00002946 
> Jan  9 17:23:34 firewall kernel:        c0126af6 00000006 0000000e 
> c01fd4c8 00000006 000001d0 c01fd4c8 00000000 
> Jan  9 17:23:34 firewall kernel: Call Trace: [shrink_cache+691/752] 
> [shrink_caches+86/128] [try_to_free_pages+48
> /80] [kswapd_balance_pgdat+68/144] [kswapd_balance+22/48] 
> Jan  9 17:23:34 firewall kernel:    [kswapd+161/192] [kswapd+0/192] 
> [kernel_thread+43/64] 
> 
> --- 8< ---
> 
> Isn't 2.4 series compatible with Pentium Classic?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

