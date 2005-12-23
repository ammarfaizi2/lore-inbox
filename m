Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVLWAGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVLWAGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLWAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:06:34 -0500
Received: from headoffice-fe1.getonit.net.au ([202.47.114.19]:43588 "EHLO
	tsvexchange.getonit.net.au") by vger.kernel.org with ESMTP
	id S1751181AbVLWAGe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:06:34 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: Kernel oops v2.4.31 in e1000 network card driver.
Date: Fri, 23 Dec 2005 10:06:19 +1000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <C67FBCB411B4024382B11B96D68E49E4079693@server.local.GetOffice>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: Kernel oops v2.4.31 in e1000 network card driver.
Thread-Index: AcYHTdvu4pFiAvcyQqC2O3AZZ/kX1QAAV1VA
From: "Tim Warnock" <timoid@getonit.net.au>
To: <linux-kernel@vger.kernel.org>
Cc: "Tim Warnock" <timoid@getonit.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Willy Tarreau [mailto:willy@w.ods.org] 
> Sent: Friday, 23 December 2005 9:17 AM
> To: Tim Warnock
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: FW: Kernel oops v2.4.31 in e1000 network card driver.
> 
> Hello,
> 
> On Thu, Dec 22, 2005 at 07:10:04PM +1000, Tim Warnock wrote:
> > Further information to this:
> > 
> > Network card causing the problem is the intel quad port 
> > gigabit ethernet pci card.
> > I have tested also on 2.4.27, 2.4.32 and the latest 2.6 
> > series kernel.
> > 
> > Under load (10-15kpps) the network driver crashes. Under 
> > increased load (20-30kpps) the driver will actually cause
> > a full kernel panic and reboot the box.
> 
> What type of system is it ? P3/P4/K7/K8 ? UP/SMP ? do you have a PCI-X
> bus in it ? have you checked /proc/interrupts for strange behaviours ?

IBM x306 p4 3.0ghz UP/HT (acpi=ht) 1gb ram 

It's a 64bit pci bus, the quad card is 64 bit also.

Underlying host os is debian sarge.

I never thought to check /proc/interrupts. I get the network card back
from remote soon, I will put it in a bench system and see what happens.
What should I be looking for in /proc/interrupts?

> > After replacing the card with a single port intel gigabit 
> ethernet pci card, the system has been rock stable.
> > 
> > According to intel, the quad port nic is based around the "Intel(r)
> > 82546EB" controller, the single port nic is based around 
> > the "Intel(r) 82545" controller.
> > 
> > Are there any other known problems with Intel(r) 82546EB controller
> > support with the current e1000 driver?
> 
> Not to my knowledge. I have several of them running on moderate volume
> (50 Mbps) on production up to 50-60 kpps, and they have never 
> ever caused any trouble after 2.5 years. I even use others in 
> stress-testing machines which throw up to 500 kpps per port without
> any problem either. BTW, the ones in the stress-testers are more
> recent, they are the ones with the "toundra" PCI bridge.
> 
> Do you encounter the problem in only one system ? I begin to suspect a
> hardware failure somewhere (CPU, RAM) which is triggered by 
> higher loads.
> 
