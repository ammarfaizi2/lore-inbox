Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272485AbTGZNqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 09:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272487AbTGZNqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 09:46:38 -0400
Received: from batman.jypoly.fi ([195.148.27.23]:44486 "EHLO batman.jypoly.fi")
	by vger.kernel.org with ESMTP id S272485AbTGZNqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 09:46:36 -0400
From: "kimmo.myllyvirta" <78161@batman.jypoly.fi>
To: h.truhetz@ecowatt.at
CC: linux-kernel@vger.kernel.org
Subject: Re: AMD760MP - Troubles with MSI K7D
Date: Sat, 26 Jul 2003 17:01:47 +0900
Message-Id: <20030726170147.M58068@batman.jypoly.fi>
X-Mailer: Open WebMail 1.64 20020415
X-OriginatingIP: 130.234.196.246 (78161)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have two Athlon MP's 2600+ mounted on a MSI K7D-Master-L with the famous 
> AMD-768 (Opus) chipset (latest BIOS 1.82).
> Actually I'm using debian's 'woody' distribution with the kernel 2.4.22-pre8, 
> glibc 2.2.5 and gcc 2.95.4.
> I have problems with the IDE support:
> On the hardisk (Maxtor 6Y120L0 - 120GB) there is a 1.4 GB file, I want to 
> copy. But when I try this, the system stops with the error message:
> 
> attempt to access beyond end of device
> 03:09: rw=0, want=976094472, limit=109948828
> 
> and I have to push the reset button.
> 
> When I switch DMA off by using 'hdparm -d0' everthing works fine, but the 
> hole copy-process takes about 8 minutes!
> 
> Are there any solutions or workarounds to fix these problems?

Plug in a PS/2 mouse, and it works.

See product errata for the AMD-768 (#10):
"Multiprocessor system may hang while in FULL APIC mode and IOAPIC interrupt
is masked"

I'm currently running similar setup (same MB, Redhat 9 + 2.4.22-pre7) without 
any problems. If the PS/2 mouse is removed i get exactly the same problems as 
you described. 

And it's not only the IDE that is affected. E.g. doing 'ifdown eth0' causes 
the system to hang (at least for me it did), so turning off the DMA is not 
a solution.

> Do I have to upgrade the glibc or any other system components?

no. (it will not solve this problem)

> Does this problem affect any inter-CPU processes like OpenMP?

no, when you have the PS/2 mouse.

> Do I have to change the motherboard? Which mobo's are said to be reliable?

Same problem appears with all motherboards using AMD 768 (rev B1 or B2). 
(Correct me if i'm wrong. Maybe some manufacturer had made workaround for 
this problem...)

Cheers,
KM

