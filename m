Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTA1F7B>; Tue, 28 Jan 2003 00:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTA1F7B>; Tue, 28 Jan 2003 00:59:01 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:61964 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S261205AbTA1F7A>;
	Tue, 28 Jan 2003 00:59:00 -0500
Date: Tue, 28 Jan 2003 07:06:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [2.4.21-pre3] APIC routing broken on ASUS P2B-DS
Message-ID: <20030128060629.GA19346@alpha.home.local>
References: <20030128004906.GA3439@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128004906.GA3439@netnation.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 04:49:06PM -0800, Simon Kirby wrote:
> Something broke between 2.4.20 and 2.4.21-pre3 which is causing
> interrupts to not be routed the second CPU.  I saw the problem on one box
> and copied the kernel to another which then had the same problem (both
> ASUS P2B-DS boards, one with PIII CPUs, one with PII CPUs).  
> 
> [sroot@devel:/]# cat /proc/interrupts
>            CPU0       CPU1       
>   0:     114480          0    IO-APIC-edge  timer
>   1:          2          0    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          3          0    IO-APIC-edge  rtc
>  16:      30707          0   IO-APIC-level  eth0
>  19:       3260          0   IO-APIC-level  aic7xxx
> NMI:          0          0 
> LOC:     114405     114404 
> ERR:          0
> MIS:          0

Hi !

Well, yesterday I've noticed the same problem here on an Asus A7M266-D. I
haven't had time to test every previous version, but I've searched through the
archives, and other similar reports have been posted since December. I believe
that some people did have it with 2.4.21pre2 too.

Your report narrows the problem down to fewer releases than what I saw first,
and if I have time I'll test 2.4.20 and 2.4.21pre1 here.

BTW, I don't know if -ac exhibits the same problem. Alan, would you check your
SMP box, please ?

Cheers,
Willy
 
