Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277588AbRJHW5f>; Mon, 8 Oct 2001 18:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277591AbRJHW5Z>; Mon, 8 Oct 2001 18:57:25 -0400
Received: from [207.21.185.24] ([207.21.185.24]:23565 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP
	id <S277588AbRJHW5V>; Mon, 8 Oct 2001 18:57:21 -0400
Message-ID: <3BC22EA6.696604E7@lnxw.com>
Date: Mon, 08 Oct 2001 15:54:30 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: discontig physical memory
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> <3BC02709.A8E6F999@welho.com> <20011007150358.G30515@nightmaster.csn.tu-chemnitz.de> <3BC05D2E.94F05935@welho.com> <20011007162439.P748@nightmaster.csn.tu-chemnitz.de> <3BC067BB.73AF1EB5@welho.com> <3BC0982A.84ECBE7B@mvista.com> <3BC0D1C9.63C7F218@welho.com> <3BC0E9FD.4F3921C6@mvista.com> <3BC2158E.BE52400D@welho.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi guys,

I ran into this problem with a SOC weird design.
The physical memory map looks like this:

	0 	-  4MB		DMA-able embedded RAM;
	4MB	- 16MB		nothing here;
	16MB	- 32MB		external RAM;

Embedded controllers (FB/USB) can see only lowest 4MB
and they need almost all of it for buffers. The kernel
is living at phy address 16Mb.

Any ideas how to make lowest 4MB allocatable throu
kmalloc(size, GFP_DMA) without breaking the kernel?


	Petko

PS: I've seen CONFIG_DISCONTIGMEM but it is not yet
implemented for MIPS and i am not sure if it is what
is required in this case.
