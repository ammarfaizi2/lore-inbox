Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSCWDZU>; Fri, 22 Mar 2002 22:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291745AbSCWDZK>; Fri, 22 Mar 2002 22:25:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60941 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291625AbSCWDZA>; Fri, 22 Mar 2002 22:25:00 -0500
Date: Fri, 22 Mar 2002 22:22:28 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Shane Nay <shane@minirl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan S2466 MPX integrated ethernet interrupt happy
In-Reply-To: <200203222229.g2MMT4t30679@zeus.kernel.org>
Message-ID: <Pine.LNX.3.96.1020322222027.24536C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Shane Nay wrote:

> I have an S2466 with an integrated 3COM 3C905C ethernet controller.  
> What I've noticed when streaming tons of data accross my internal LAN 
> is that the ethernet driver appears to be sucking up tons of cycles.

The table is just the number of ints, see below for one of my boxen which
is running 200-250 users and has idle of ~92% over three days.
 
> A quick investigation of /proc/interrupts shows-
>   0:     195949     192414    IO-APIC-edge  timer
>   1:       5126       5129    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   5:          0          0   IO-APIC-level  usb-ohci
>   8:          1          0    IO-APIC-edge  rtc
>   9:    4248819    4245969   IO-APIC-level  eth0
>  10:     144865     145243   IO-APIC-level  usb-ohci, nvidia, EMU10K1
>  12:      48546      48865    IO-APIC-edge  PS/2 Mouse
>  14:     122395     121652    IO-APIC-edge  ide0
>  15:      26286      26498    IO-APIC-edge  ide1
> NMI:          0          0 
> LOC:     388204     388212 
> ERR:          0
> MIS:          4

newssvr17:twister$ cat /proc/interrupts 
           CPU0       CPU1       
  0:   14112007   14110727    IO-APIC-edge  timer
  1:        473        467    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
 12:        104        105    IO-APIC-edge  PS/2 Mouse
 14:          3          2    IO-APIC-edge  ide0
 18:   88268186   88280808   IO-APIC-level  eth0
 20:    6655721    6658714   IO-APIC-level  ips
 27:   74212944   74213812   IO-APIC-level  PCnet/FAST III 79C975
 28:         14          2   IO-APIC-level  aic7xxx
 29:         10          6   IO-APIC-level  aic7xxx
NMI:          0          0 
LOC:   28223102   28223059 
ERR:          0
MIS:          0

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

