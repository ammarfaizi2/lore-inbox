Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289162AbSAGKPI>; Mon, 7 Jan 2002 05:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289166AbSAGKO4>; Mon, 7 Jan 2002 05:14:56 -0500
Received: from weta.f00f.org ([203.167.249.89]:48581 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S289162AbSAGKOq>;
	Mon, 7 Jan 2002 05:14:46 -0500
Date: Mon, 7 Jan 2002 23:17:47 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "APIC error on CPUx" - what does this mean?
Message-ID: <20020107101747.GA27284@weta.f00f.org>
In-Reply-To: <20020103195551.BEHH23959.femail47.sdc1.sfba.home.com@there> <E16MGVH-0001Jl-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16MGVH-0001Jl-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 10:38:27PM +0000, Alan Cox wrote:

    The occasional APIC error is fine (its logging a hardware event -
    probably something that caused enough noise to lose a message and
    retry it). The APIC bus is designed to stand these occasional
    errors

I'm curious... is there any way to determine what is causing these?
On a UP athlon I have:

cw:tty5@charon(cw)$ uname -r ; uptime && grep ERR /proc/interrupts
2.4.17-rc2
 02:09:50 up 4 days,  5:18, 10 users,  load average: 0.00, 0.00, 0.00
ERR:       5216

which equates several per minute at times... no funny hardware, not
running X11, and I don't remembering seeing these a while ago on this
same mainboard (but I never really looked either, so that might not be
true).

On a similar Athlon box, which has been up 32 days, I have nearly 45000
events, whilst on a UP P3 which has been up for 124 days I see none,
another UP PII which has been up for 196 days see's none, an SMP P3
which has been up 150 days sees none too...  is this an Athlon or VIA
chipset quirk perhaps?



  --cw

