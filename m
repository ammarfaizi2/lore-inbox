Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277702AbRJLSi7>; Fri, 12 Oct 2001 14:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277687AbRJLSit>; Fri, 12 Oct 2001 14:38:49 -0400
Received: from colorfullife.com ([216.156.138.34]:24587 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S277348AbRJLSih>;
	Fri, 12 Oct 2001 14:38:37 -0400
Message-ID: <3BC738AD.A0329BBF@colorfullife.com>
Date: Fri, 12 Oct 2001 20:38:37 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org,
        Sean Cavanaugh <seanc@gearboxsoftware.com>
Subject: Re: P4 SMP load balancing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > ovendev:~# cat /proc/interrupts 
> >            CPU0       CPU1       
> >   0:    6348212          0    IO-APIC-edge  timer
> >   1:          2          0    IO-APIC-edge  keyboard
> >   2:          0          0          XT-PIC  cascade
> >   8:          1          0    IO-APIC-edge  rtc
> >   9:          0          0    IO-APIC-edge  acpi
> >  16:      92620          0   IO-APIC-level  eth0
> >  18:       5085          0   IO-APIC-level  aic7xxx, aic7xxx
> > NMI:          0          0 
> > LOC:    6348388    6348427 
> > ERR:          0
> > MIS:          0
> 
> I don't think this should happen. In the event of both procs having equal 
> priority (linux never changes them, so they always do), we should fall back 
> to the arbitration priority of the lapic. Whether you have 1 or 2 I/O apics
> working shouldn't make a difference. 

The P 4 has a new apic, and lowest priority delivery doesn't work
anymore.

<<<<<<< Chapter 7.6.10 of 24547202.pdf
In operating systems that use the lowest priority interrupt delivery
mode
but do not update the TPR, the TPR information saved in the chipset will
potentially cause the interrupt to be always delivered to the same
processor from the logical set. This behavior is functionally backward
compatible with the P6 family processor but may result in unexpected
performance implications.
<<<<<<< (search for 245472 on google for the pdf file)


--
	Manfred
