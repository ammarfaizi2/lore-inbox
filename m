Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131943AbRA0I1t>; Sat, 27 Jan 2001 03:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132119AbRA0I1j>; Sat, 27 Jan 2001 03:27:39 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:42824 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131940AbRA0I10>; Sat, 27 Jan 2001 03:27:26 -0500
Message-ID: <3A7211BB.AF85D0BC@ngforever.de>
Date: Fri, 26 Jan 2001 17:09:31 -0700
From: Thunder from the hill <thunder@ngforever.de>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD QXW03240  (WinNT; U)
X-Accept-Language: de,en-US
MIME-Version: 1.0
To: Stefani Seibold <stefani@seibold.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: patch for 2.4.0 disable printk
In-Reply-To: <01012612051000.01240@deepthought.seibold.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefani Seibold wrote:
> 
> Hi Linus,
> Hi Alan,
> Hi everybody,
> 
> this kernel patch allows to disable all printk messages, by overloading the
> printk function with a dummy printk macro.
> 
> This patch is usefull for embedded systems, where the hardware never changes
> and normaly no textconsole is attachted nor any user will see the boot
> messages. Also, it is nice for rescue disks.
> 
> On my system this saves about 10% of disk- and ramspace.
> 899664
> For example: My standart desktop kernel is 994834 bytes, without printk
> messages it is only 899664 bytes long. The basic kernel ram usage is also 10%
> less than the same kernel with printk messages.
> 
> Greetings,
> Stefani
> 
> BTW: this is my first try to submit a kernel patch
What sense does it make to ripp the kernel off its "tongue"? This means
to make it completely silent, a oops() could _not_ be noticed! This
means that you don't know when your system has nearly crashed.
You'd better leave printk where it is.

Thunder
---
Woah... I did a "cat /boot/vmlinuz >> /dev/audio" - and I think I heard
god...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
