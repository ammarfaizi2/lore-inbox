Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314124AbSDQPL6>; Wed, 17 Apr 2002 11:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314125AbSDQPL5>; Wed, 17 Apr 2002 11:11:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15571 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S314124AbSDQPLz>;
	Wed, 17 Apr 2002 11:11:55 -0400
Date: Wed, 17 Apr 2002 15:08:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: James Bourne <jbourne@MtRoyal.AB.CA>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Jeff Nguyen <jeff@aslab.com>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.44.0204170808160.17511-100000@skuld.mtroyal.ab.ca>
Message-ID: <Pine.LNX.4.44.0204171507300.23328-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Apr 2002, James Bourne wrote:

> After Ingo forwarded me his original patch (I found his patch via a web
> based medium, which had converted all of the left shifts to compares,
> and now I'm very glad it didn't boot...) and the system is booted and is
> balancing most of the interrupts at least.  Here's the current output of
> /proc/interrupts
> 
> brynhild:bash$ cat /proc/interrupts 
>            CPU0       CPU1       
>   0:     171414          0    IO-APIC-edge  timer
>   1:          3          2    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          1          0    IO-APIC-edge  rtc
>  18:          8          7   IO-APIC-level  aic7xxx
>  19:      13566      12799   IO-APIC-level  eth0
>  20:          9          7   IO-APIC-level  aic7xxx
>  21:          9          7   IO-APIC-level  aic7xxx
>  27:       1572       5371   IO-APIC-level  megaraid
> NMI:          0          0 
> LOC:     171315     171251 
> ERR:          0
> MIS:          0

it's looking good.

> So, the timer isn't being balanced still, others are (is there a
> specific case in your patch for irq 0 (< 1)?  I couldn't see it but it
> almost looks as though it's being missed..)

it's a separate bug, solved by a separate patch.

	Ingo

