Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSCWBYV>; Fri, 22 Mar 2002 20:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292178AbSCWBXP>; Fri, 22 Mar 2002 20:23:15 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S293680AbSCWBPP>;
	Fri, 22 Mar 2002 20:15:15 -0500
Message-Id: <200203222229.g2MMT4t30679@zeus.kernel.org>
X-pair-Authenticated: 68.5.32.62
Content-Type: text/plain; charset=US-ASCII
From: Shane Nay <shane@minirl.com>
To: linux-kernel@vger.kernel.org
Subject: Tyan S2466 MPX integrated ethernet interrupt happy
Date: Fri, 22 Mar 2002 14:29:12 -0800
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an S2466 with an integrated 3COM 3C905C ethernet controller.  
What I've noticed when streaming tons of data accross my internal LAN 
is that the ethernet driver appears to be sucking up tons of cycles.

A quick investigation of /proc/interrupts shows-
  0:     195949     192414    IO-APIC-edge  timer
  1:       5126       5129    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:          0          0   IO-APIC-level  usb-ohci
  8:          1          0    IO-APIC-edge  rtc
  9:    4248819    4245969   IO-APIC-level  eth0
 10:     144865     145243   IO-APIC-level  usb-ohci, nvidia, EMU10K1
 12:      48546      48865    IO-APIC-edge  PS/2 Mouse
 14:     122395     121652    IO-APIC-edge  ide0
 15:      26286      26498    IO-APIC-edge  ide1
NMI:          0          0 
LOC:     388204     388212 
ERR:          0
MIS:          4


So, approximately 8.5 million ethernet interrupts.  The system is 
noticably slower when streaming ethernet data, and it's sucking up a 
lot more processing time than on my other much slower other box.  
This box is running a stock 2.4.18 kernel from kernel.org (i.e. no 
custom hacks).  It's running 2 1800+ XPs.

I'm wondering if anyone has seen this and has a quick solution.  If 
not I'll take a look through the 3com code when I get back from 
vacation next Sunday.  (Leaving in a few hours)

Thanks,
Shane Nay.
