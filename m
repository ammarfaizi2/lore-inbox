Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131470AbRABTDN>; Tue, 2 Jan 2001 14:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRABTCz>; Tue, 2 Jan 2001 14:02:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131199AbRABTCt>; Tue, 2 Jan 2001 14:02:49 -0500
Date: Tue, 2 Jan 2001 13:32:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <20010102191458.B4299@emma1.emma.line.org>
Message-ID: <Pine.LNX.3.95.1010102132531.1518A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Matthias Andree wrote:

> On Sun, 31 Dec 2000, Linus Torvalds wrote:
> 
> > Ok. I didn't make 2.4.0 in 2000. Tough. I tried, but we had some
> > last-minute stuff that needed fixing (ie the dirty page lists etc), and
> > the best I can do is make a prerelease.
> 
> I just compiled that one into a 1032 kB kernel, and it failed to be
> booted from GRUB 0.5.95 (some CVS version). I then made USB into
> modules, the kernel was 887 kB and booted. Is Linux 2.4 supposed to
> suffer from the 1 M limit still?
> 

`make bzImage` gives you an image that can be (practically) any size.
I don't know anything about GRUB. However, LILO handles it fine.

When LILO boots, it reads up to 64k at a time, relocates this above
1 megabyte by using INT 0x15, then reuses the same buffer over and
over again. Therefore, it doesn't have a "size" problem since it only
uses 64k + some code-space, in an area that has at least 512 kbytes.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
