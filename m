Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130573AbRBMOQJ>; Tue, 13 Feb 2001 09:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbRBMOP6>; Tue, 13 Feb 2001 09:15:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39808 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130573AbRBMOPx>; Tue, 13 Feb 2001 09:15:53 -0500
Date: Tue, 13 Feb 2001 09:15:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Marcus Ramos <marcus@ansp.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with kernel-module version mismatch
In-Reply-To: <3A892AC4.1BE7B4F1@ansp.br>
Message-ID: <Pine.LNX.3.95.1010213090905.17758A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Marcus Ramos wrote:

> Hello,
> 
> After compiling files "ttime.c" and "ttime.h", I try to load them into
> the kernel using the command /sbin/insmod ttime.o. However, the
> following message suggests that a version conflict  has prevented the
> loading to be performed correctly:
> 
> "kernel-module version mismatch. ttime.o was compiled for kernel
> 2.4.0-0.26 while this kernel is version 2.2.16-22".
> 
> My question is: since the source has been compiled on the same kernel as
> it is going to be loaded into, how come this message ? What do I have to
> do in order to avoid such problem ? Change the source code ? Where did
> it learn about 2.4.0-0.26 if I am using 2.2.16-22 (Red Hat 7.0) ?
> 
> Thanks in advance,
> Marcus.
> 

`uname -r` shows the currently executing kernel version. The version
of the kernel you compiled is in the top of the Makefile (first 3 lines).

To see if you are lucky, you can "force" the module loading with
`insmod -f ttime.o`.

FYI, it looks like you thought you installed a new kernel after you
compiled it, but didn't. 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


