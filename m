Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRB0UZX>; Tue, 27 Feb 2001 15:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129841AbRB0UZO>; Tue, 27 Feb 2001 15:25:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64899 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129495AbRB0UZE>; Tue, 27 Feb 2001 15:25:04 -0500
Date: Tue, 27 Feb 2001 15:24:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rob <rob@hereintown.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compilation problems
In-Reply-To: <Pine.LNX.4.30.0102271442010.967-100000@robsdigs.hereintown.net>
Message-ID: <Pine.LNX.3.95.1010227151536.21059A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, Rob wrote:

> Hi, I've encountered a problem compiling the 2.4.2 kernel.
> 
> I downloaded the source, did a make menuconfig, make dep, make bzImage;
> everything went ok, but I didn't have the NIC working correctly. I
> recompiled, it seemed to go ok but still the NIC didn't work.  Then I
> tried make clean, make mrproper, make menuconfig, make dep, make bzImage,
> and now I keep getting an error at the very end of the compile process...
> 
> init/main.o(.text.init+0x53): undefined reference to
> `__buggy_fxsr_alignment'
> make: ***[vmlinux] Error 1
> 

You need to upgrade your binutils or 'C' compiler. This is a forced error
caused by task struct member, 'thread.i387.fxsave' not being aligned on a
16-byte boundary.  In the meantime, you could actually create a global
function in main.c and see if the machine runs.

__buggy_fxsr_alignment(){}


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


