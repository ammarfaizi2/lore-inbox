Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbQJaD3r>; Mon, 30 Oct 2000 22:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbQJaD3i>; Mon, 30 Oct 2000 22:29:38 -0500
Received: from ns.electricgod.net ([206.145.235.49]:4114 "EHLO
	ns.electricgod.net") by vger.kernel.org with ESMTP
	id <S130069AbQJaD30>; Mon, 30 Oct 2000 22:29:26 -0500
Date: Mon, 30 Oct 2000 21:28:48 -0600 (CST)
From: Joshua Jore <moomonk@ns.electricgod.net>
To: stewart@neuron.com
cc: linux-kernel@vger.kernel.org
Subject: Re: trouble with apm on dell latitude cs in 2.2.1[67]
In-Reply-To: <Pine.LNX.4.10.10010281227460.1211-100000@localhost>
Message-ID: <Pine.BSF.4.21.0010302128070.67875-100000@ns.electricgod.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to recall there is mention of this in the recent pcmcia-cs
sources. This requires playing with hdparm if I remember correctly.

Josh

On Tue, 31 Oct 2000 stewart@neuron.com wrote:

> 
>  I've recently upgraded a latitude cs running redhat 6.2 on 2.2.14 with
>  card services v3.1.14 to 2.2.17 with card services v3.1.21. Immediately
>  I noticed that suspend/resume was broken. Well, suspend was working fine
>  but when I raised the lid, the system would come back like normal, then
>  the HD drive light would go solid and a few seconds later the system
>  would lock hard. No oops or any other indicators. I tried tailing the
>  /var/log/messages file (starting before the suspend), but this revealed
>  nothing at first. After about 5 tries I managed to elicit one error
>  in the log:
> 
>  "hda: timeout waiting for DMA"
> 
>  but this message did not show up consistently. I tried backing down to
>  2.2.16 in case it was a recent bug and then also tried backing up to a
>  previous version of card services, but none of this helps. Unless I go
>  back to 2.2.14, this system will lock hard on a resume about 7-10 seconds
>  after I raise the lid.
> 
>  Lacking any other kernel debugging skills, I compiled sysrq into the kernel
>  hoping to get something more useful for the list. Although 'showkey -s'
>  does generate 0x54 codes, pressing alt-sysrq-<key> yields nothing in the
>  kernel I just built it into (2.2.17). 
> 
>  One another kernel note, I cannot get the 2.4.0-test9/10 kernels to boot
>  on this machine. After lilo, it says:
> 
>  "Uncompressing Linux... Ok, booting the kernel."
> 
>  then the machine hangs solid. It is not recoverable via alt-ctrl-del.
>  I have to hold the power button until the machine cycles. I have no data
>  for earlier 2.4.0 kernels.
> 
>  What else can I do to debug this and what other info will help in
>  identifying the problem?
> 
>  Thanks,
> 
>  Stewart
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
