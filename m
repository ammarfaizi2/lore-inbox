Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137206AbREKSp2>; Fri, 11 May 2001 14:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137204AbREKSpS>; Fri, 11 May 2001 14:45:18 -0400
Received: from cx595243-c.okc1.ok.home.com ([24.6.27.53]:38022 "EHLO
	quark.localdomain") by vger.kernel.org with ESMTP
	id <S137206AbREKSpH>; Fri, 11 May 2001 14:45:07 -0400
From: Vincent Stemen <linuxkernel@AdvancedResearch.org>
Date: Fri, 11 May 2001 13:45:24 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: "Jacky Liu" <jq419@my-deja.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200105100357.UAA16327@mail25.bigmailbox.com>
In-Reply-To: <200105100357.UAA16327@mail25.bigmailbox.com>
Subject: Re: 2.4.4 kernel freeze for unknown reason
MIME-Version: 1.0
Message-Id: <01051113452400.07411@quark>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 May 2001 22:57, Jacky Liu wrote:
> Dear All,
>
> I would like to post a question regarding to a problem of unknown freeze of
> my linux firewall/gateway.
>
> Here is the hardware configuration of my machine:
>
> AMD K-6 233 MHz
> 2theMax P-55 VP3 mobo
> 64Mb RAM in a single module (PC-100)
> Maxtor 6G UDMA-33 harddisk
> Matrox MG-II display card w/8Mb RAM
> 3Com 3C905B-TX NIC
> RealTek 8129 10/100 NIC
>
> It's running 2.4.4 kernel (RedHat 7.1) and acting as a firewall using
> Netfilter (gShield and Snort), DNS (Cache-Only DNS) and NAT gateway
> (ip-masq.) for my home network. I used 3C905B-TX NIC as my internal NIC and
> RealTek 8129 as my external NIC. Here is the problem:
>
> The machine has been randomly lockup (totally freeze) for number of times
> without any traceable clue or error message. Usually the time frame between
> each lockup is between 24 to 72 hours. The screen just freeze when it's
> lockup (either in Console or X) and no "kernel panic" type or any error
> message prompt up. All services (SSH, DNS, etc..) are dead when it's lockup
> and I cannot find any useful information in /var/log/messages. I cannot
> reproduce the lockup since it's totally randomly. The lockup happened
> either when I was playing online game (A LOT, like getting thousands of
> server status in counter-strike in a very short time frame, of NAT
> traffic), surfing the web (normal traffic) or the machine was totally in
> idle (lockup when I was sleeping). It was lockup this morning when I was
> playing online game (when my game machine was trying to establish
> connection to a game server).
>
> If there is any information you would like to obtain, please let me know. I
> would like to receive a copy of your reply, thank you very much for your
> kindly attention.
>

I have been experiencing these same problems since version 2.4.0.
Although, I think it has improved a little in 2.4.4, it still locks
up.  The problem seems to be related to memory management and/or swap,
and is seems to do it primarily on machines with over 128Mb of RAM.
Although, I have not tested systematically enough to confirm this.

I have been monitoring the memory usage constantly with the gnome
memory usage meter and noticed that as swap grows it is never freed
back up.  I can kill off most of the large applications, such as
netscape, xemacs, etc, and little or no memory and swap will be freed.
Once swap is full after a few days, my machine will lock up.

If I turn swap off all together or turn it off and back on
periodically to clear the swap before it gets full, I do not seem to
experience the lockups.

I am running on an AMD K6-400 with 256 Mb RAM but we have experienced
these problems with various other machines as well.

I hope this information is helpfull in tracking down the problem.


The features of the 2.4.x kernels are great and I believe all the
kernel developers have done a fantastic job!  However, I am
disappointed that we are now on the forth 2.4.x kernel version and
such as serious problem that has been there since 2.4.0 still exists.
This is pretty much a show stopper for having a production machine.
In the past when I was running on 2.0.3x kernels, I boasted to
everybody about how rock solid Linux was and I was able to run for 5
months without a single reboot or problem, but for the last year or
more I have not had much better uptime than certain other commercial
operating systems.  As important as the new features are, stability
should be top priority for production systems.  I apologize if this
sounds a bit like a rant but I feel that ever since the 2.2.x kernel
series, the Linux kernel community has veered away from it's original
philosophy of only releasing stable kernels with even numbered
versions.  In fact, I have seen several even numbered kernels released
with far less stability than most of the odd numbered development
kernels.

- Vincent 

