Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQJ3Q3l>; Mon, 30 Oct 2000 11:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129068AbQJ3Q3c>; Mon, 30 Oct 2000 11:29:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4868 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129066AbQJ3Q3V>; Mon, 30 Oct 2000 11:29:21 -0500
Date: Mon, 30 Oct 2000 11:28:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tigran Aivazian <tigran@veritas.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.4.21.0010301602240.2383-100000@saturn.homenet>
Message-ID: <Pine.LNX.3.95.1001030112739.1186B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Tigran Aivazian wrote:

> Hi Dick,
> 
> Sorry, I thought you knew this already :) The maximum for kmalloc is 128K
> and is defined in mm/slab.c. It is trivial to "enhance" slab.c to support
> more but it is in practice not very useful because requesting too much
> physically-contiguous (which kmalloc is all about) memory is impossible
> except at very early stages after boot (due to obvious fragmentation).
> 
> So, if you don't need physically contiguous (and fast) allocations perhaps
> you could make use of vmalloc()/vfree() instead? There must be also some
> "exotic" allocation APIs like bootmem but I know nothing of them so I stop
> here.
> 
> Regards,
> Tigran
> 
> 

Okay. Looks like I need a linked-list so I can use noncontiguous memory.



Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
