Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266914AbRGMXzO>; Fri, 13 Jul 2001 19:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbRGMXzF>; Fri, 13 Jul 2001 19:55:05 -0400
Received: from fire.osdlab.org ([65.201.151.4]:17830 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S266914AbRGMXyw>;
	Fri, 13 Jul 2001 19:54:52 -0400
Message-ID: <3B4F8A16.83EF0CA1@osdlab.org>
Date: Fri, 13 Jul 2001 16:53:58 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vandrove@vc.cvut.cz, lkml <linux-kernel@vger.kernel.org>
Subject: RE: Using ACPI to get PCI routing info?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr-

Where does someone find/get BIOS version F5a for the 6VXD7?
The latest that I see on the Gigabyte web pages is F5.

Thanks,
~Randy

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hi,
  Gigabyte (and/or AMI and/or VIA) decided that it is not worth 
of effort to create full mptable and since version F5a for 6VXD7 
they do not report PCI interrupts as 16-19, but only as traditional 
0-15 (and they do not report them as conforms/conforms, but as 
active-lo/level).

  For now I hardwired correct routing table into my kernel, as
I have other uses for IRQ < 16, but after some investigation I 
found that ACPI _SB_.PCI0._PRT element returns correct routing 
table (using IRQ 16-19). So my question is, are there any plans 
to use ACPI tables to get IRQ routing tables, or should I complain 
to Gigabyte that I'm not satisfied (I'll complain anyway, but...)?

                                        Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

P.S.: No, there is no MPS1.1/MPS1.4 switch in BIOS (anymore) :-(
And no, there is no way to disable ACPI in that BIOS :-((

/* Old working BIOS... 6VXD7 - F2 */
...
/* 'Broken' 6VXD7 - F5a */
...
