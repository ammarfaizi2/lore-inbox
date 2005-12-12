Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVLLI0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVLLI0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVLLI0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:26:51 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:13514 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S1751131AbVLLI0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:26:50 -0500
Date: Mon, 12 Dec 2005 09:26:16 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-Reply-To: <20051211.210752.83944980.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0512120919410.12409@lai.local.lan>
References: <Pine.LNX.4.64.0512102350310.4739@lai.local.lan>
 <20051210.150034.67577008.davem@davemloft.net> <Pine.LNX.4.64.0512110020050.4809@lai.local.lan>
 <20051211.210752.83944980.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Dec 2005, David S. Miller wrote:
> From: "J.O. Aho" <trizt@iname.com>

>> sbusfb_mmap: start[71800000] size[410000] off[4000000]
>> sbusfb_mmap: page[0] map_size[2000]
>> sbusfb_mmap: map_size is now 2000
>> IO[X:6712]:
>> remap_pfn_range(s[71800000]e[71c10000],f[71800000],pfn[1fc0060],sz[2000],prot[80000000000006b0])
>> sbusfb_mmap: page[2000] map_size[2000]
>> sbusfb_mmap: map_size is now 2000
>> IO[X:6712]:
>> remap_pfn_range(s[71800000]e[71c10000],f[71802000],pfn[1fc0060],sz[2000],prot[80000000000006b0])
>
> This means, it passes in "vma->vm_start + page" in as the start
> address.
>
> Yet the last line, printed by the tracing code in io_remap_pfn_range()
> is getting 0x71800000, when it should be 0x71802000.
>
> I strongly believe your kernel is being miscompiled by whatever
> gcc is being used to build your kernels.

Okey, good that there is something I can try and see. I'll see what a 
rebuild does of the gcc 64bit and have as basic CFLAGS as possible doing 
this and rebuild the kernel and see what happens, if not, I guess I'll 
bugger the Gentoo Sparc guys again.

Thanks for the help.

-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
