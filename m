Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTKFP0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTKFP0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:26:47 -0500
Received: from mail.atlanticpositioners.com ([151.203.97.44]:45222 "EHLO
	mail.atlanticpositioners.com") by vger.kernel.org with ESMTP
	id S263645AbTKFP0p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:26:45 -0500
Content-Class: urn:content-classes:message
Subject: reassigning IRQs for specific PCI slots...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Importance: normal
Date: Thu, 6 Nov 2003 10:25:35 -0500
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4925.2800
Message-ID: <13811E54B99D7C4AA403E725583A356F0BBB72@mail-server.atlanticpositioners.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: reassigning IRQs for specific PCI slots...
thread-index: AcOkejmgmd2OLTKbSKWWXnCUy2rXWA==
From: "Robert Bird" <rbird@Atlanticpositioners.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We are trying to use RTLinux thread to service a PCI-based multi-port serial card.  I have read several documents regarding "sharing IRQs", using boot-prompt parameters, IO-APIC.txt, etc.  I am being told by the RTLinux community that I must not share interrupts when using real-time thread to service a PCI-based function.  I have tried using several combinations of boot-prompt parameters (we are using GRUB) but have had no success in redirecting IRQ assignment during boot-time!

I have tried to use "pirq=" boot parameter.....the booting kernel does acknowledge the parameter but appears to forget about it when PCI probing occurs.  It assigns my two PCI-based boards the same way each time: slot #1=5, slot #2=11.  I have made some semi-smart attempts to use the "pci=" parameters "nobios", "noapic" (my kernel does not recognize this one), and "nosort" in conjunction with the "pirq=" parameter.  [I guess my "semi-smart attempts" are not that smart].

Is it possible to do what I want to do?  Would you have any ideas on what I could try next.

I am not using a multi-processor board but have selected the IO-APIC option before making the compiler.


What I am using:
- kernel: GPL 2.4.18 (with IO-APIC compiled in)
- RTLinux: 3.2-pre1
-Tyan motherboard with PIII
- gcc 3.2.1

Thanks in advance for taking the time to respond to my queries.

Regards.....Robert


++++++++++++++++++++++++++++++++++++++
Robert Bird
Senior Engineer, Electrical
Atlantic Positioning Systems
Atlantic Division, Atlantic Microwave Corporation
Internet Address: rbird@atlanticpositioners.com
Internet Site:       http://www.atlanticpositioners.com


6/11/2003
rbird@Atlanticpositioners.com
This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately by e-mail if you have received this e-mail by mistake and delete this e-mail from your system. If you are not the intended recipient you are notified that disclosing, copying, distributing or taking any action in reliance on the contents of this information is strictly prohibited.

