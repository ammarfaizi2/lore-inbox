Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271772AbRH0QgZ>; Mon, 27 Aug 2001 12:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271775AbRH0QgQ>; Mon, 27 Aug 2001 12:36:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49281 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271772AbRH0QgK>; Mon, 27 Aug 2001 12:36:10 -0400
Date: Mon, 27 Aug 2001 12:36:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jens Hoefkens <hoefkens@msu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 boot failure
In-Reply-To: <Pine.LNX.4.21.0108271157230.8066-100000@dvorak>
Message-ID: <Pine.LNX.3.95.1010827123227.31563A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Jens Hoefkens wrote:

> 
> Hi Folks.
> 
> I have a M54Pe-12M dual Pentium board with 2xP100. The machine boots
> fine with a single CPU kernel (dmesg output [1] and kernel config [2]
> below), but fails to boot with SMP kernels (config below [3]).
> 
> All I get is the message "Uncompressing Linux... OK, booting the
> kernel" and then the system hangs (the keyboard is completely dead, no
> numlock, caps lock, or Ctrl-Alt-Del). And to be sure, I have run LILO
> after installing the new kernel.
> 
> Since this is a toy project and not a production machine, I can run
> any kind of tests with it...
> 
> 
> Thanks,
> 	
> 							Jens
[SNIPPED...]

There may be a configuration problem. Make sure that you do:

make oldconfig
make dep
make clean
make bzImage
make modules
make modules_install

... after you set the SMP variable. A mixture of SMP and non-SMP
code can cause hangs.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


