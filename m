Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137015AbREKASY>; Thu, 10 May 2001 20:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137016AbREKASO>; Thu, 10 May 2001 20:18:14 -0400
Received: from cj46222-a.reston1.va.home.com ([65.1.136.109]:20096 "HELO
	troilus.org") by vger.kernel.org with SMTP id <S137015AbREKARz>;
	Thu, 10 May 2001 20:17:55 -0400
To: linux-kernel@vger.kernel.org
Subject: eepro100/usb interrupts stop with 2.4.x kernels?
From: Michael Poole <poole@troilus.org>
Date: 10 May 2001 20:17:49 -0400
Message-ID: <m3wv7od9hu.fsf@troilus.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Solid Vapor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since about 2.4.2, I have been seeing intermittent hangs on my system;
usually once or twice a week, but once just 10 minutes after rebooting.

What seems to happen is that the kernel stops seeing interrupts on the
IRQ shared by eth0 (my outside interface) and usb-uhci.  I can still
ssh in on eth1, and when I do, syslog contains things like "eth0:
Interrupt timed out" and usb-uhci griping about devices that failed to
accept new endpoints.

I'm not sure if for some reason my chipset stopped passing these
interrupts on to the kernel, or if the kernel got into some funny
state and stopped accepting those interrupts.  Any hints on where I
should look?

>From /proc/interrupts now:
           CPU0       CPU1       
  0:     243741     233914    IO-APIC-edge  timer
  1:          4          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          0    IO-APIC-edge  rtc
 10:          0          0   IO-APIC-level  EMU10K1
 11:      18775      17937   IO-APIC-level  usb-uhci, eth0
 12:       1221       1236   IO-APIC-level  eth1
 14:      84039      68162    IO-APIC-edge  ide0
 15:         18         18   IO-APIC-level  BusLogic BT-950
NMI:          0          0 
LOC:     477548     477547 
ERR:          0

-- Michael
