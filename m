Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289881AbSAOPDE>; Tue, 15 Jan 2002 10:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289882AbSAOPCy>; Tue, 15 Jan 2002 10:02:54 -0500
Received: from Expansa.sns.it ([192.167.206.189]:49170 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S289881AbSAOPCr>;
	Tue, 15 Jan 2002 10:02:47 -0500
Date: Tue, 15 Jan 2002 16:02:37 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Amit Gupta <amit.gupta@amd.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: arpd not working in 2.4.17 or 2.5.1
In-Reply-To: <3C4380F2.292475B9@cmdmail.amd.com>
Message-ID: <Pine.LNX.4.44.0201151555590.24858-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latest  kernel I saw working with arpd (user space daemon) I am manteining
is 2.2.16, then from 2.4.4 (for 2.4 series), some changes were done to
kernel so that the kernel does not talk correctly with the device
/dev/arpd anymore.
It is not the first time I write about this on lkml, but it seems none is
interested in manteining the kernel space component for arpd support.
I did some investigation, but the code for arpd support itself inside of
the kernel seems to be ok, something else is wrong with neighour.c.

So at less I can say the user space daemon works well on 2.2.16 I have
around ;).

Luigi

On Mon, 14 Jan 2002, Amit Gupta wrote:

>
> Hi All,
>
> I am running 2.5.1 kernel on a 2 AMD processor system and have enable
> routing messages, netlink and arpd support inside kernel as described in
> arpd docs.
>
> Then after making 36 character devices, when I run arpd, it's starts up
> but always keeps silent (strace) and the kernel also does not keep it's
> 256 arp address limit.
>
> Pls help fix it, I need linux to be able to talk to more than 1024
> clients.
>
> Thanks in Advance.
>
> Amit
> amit.gupta@amd.com
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


