Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWJXSIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWJXSIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWJXSIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:08:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:51848 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161130AbWJXSID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:08:03 -0400
Subject: Re: Linux 2.6.19-rc3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>
In-Reply-To: <20061024074622.GC4354@rhun.haifa.ibm.com>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	 <20061024074622.GC4354@rhun.haifa.ibm.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 11:07:56 -0700
Message-Id: <1161713276.18096.31.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-24 at 09:46 +0200, Muli Ben-Yehuda wrote:
> On Mon, Oct 23, 2006 at 04:22:59PM -0700, Linus Torvalds wrote:
> > 
> > Ok,
> >  a few days late, because I'm a retard and didn't think of doing a release 
> > when I should have. 
> > 
> > I'm also a bit grumpy, because I think people are sending me more stuff 
> > than they should at this stage in the game. We've been pretty good about 
> > keeping the later -rc releases quiet, please keep it that way.
> > 
> > That said, it's mostly harmless cleanups and some architecture updates. 
> > And some of the added warnings about unused return values have caused a 
> > number of people to add error handling. And on the driver front, there's 
> > mainly new driver ID's, and a couple of new drivers.
> 
> The genirq changes broke boot on my x86-64 x366 machine. It needs
> these two patches:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116157813623508&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116157837104613&w=2


Yes. Without these patches, I can't seem to get my qlogic driver
to work :(

Thanks,
Badari

ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 17
qla2xxx 0000:01:05.0: Found an ISP2200, irq 17, iobase
0xffffc20000064000
qla2xxx 0000:01:05.0: Configuring PCI space...
qla2xxx 0000:01:05.0: Configure NVRAM parameters...
qla2xxx 0000:01:05.0: Verifying loaded RISC code...
qla2xxx 0000:01:05.0: Allocated (252 KB) for firmware dump...
qla2xxx 0000:01:05.0: LIP reset occured (f723).
qla2xxx 0000:01:05.0: Waiting for LIP to complete...
qla2xxx 0000:01:05.0: LIP occured (f723).
qla2xxx 0000:01:05.0: LOOP UP detected (1 Gbps).
qla2xxx 0000:01:05.0: Topology - (Loop), Host Loop address 0x7d
qla2xxx 0000:01:05.0: Failed to reserve interrupt 17 already in use.
qla2xxx: probe of 0000:01:05.0 failed with error -38
ACPI: PCI Interrupt 0000:0f:01.0[A] -> GSI 29 (level, low) -> IRQ 29
qla2xxx 0000:0f:01.0: Found an ISP2312, irq 29, iobase
0xffffc20000064000
qla2xxx 0000:0f:01.0: Configuring PCI space...
qla2xxx 0000:0f:01.0: Configure NVRAM parameters...
qla2xxx 0000:0f:01.0: Verifying loaded RISC code...
qla2xxx 0000:0f:01.0: Allocated (412 KB) for firmware dump...
qla2xxx 0000:0f:01.0: Waiting for LIP to complete...
qla2xxx 0000:0f:01.0: Cable is unplugged...
qla2xxx 0000:0f:01.0: Failed to reserve interrupt 29 already in use.
qla2xxx: probe of 0000:0f:01.0 failed with error -38
ACPI: PCI Interrupt 0000:19:01.0[A] -> GSI 37 (level, low) -> IRQ 37
qla2xxx 0000:19:01.0: Found an ISP2200, irq 37, iobase
0xffffc20000064000
qla2xxx 0000:19:01.0: Configuring PCI space...
qla2xxx 0000:19:01.0: Configure NVRAM parameters...
qla2xxx 0000:19:01.0: Verifying loaded RISC code...
qla2xxx 0000:19:01.0: Allocated (252 KB) for firmware dump...
qla2xxx 0000:19:01.0: LIP reset occured (f725).
qla2xxx 0000:19:01.0: Waiting for LIP to complete...
qla2xxx 0000:19:01.0: LIP occured (f725).
qla2xxx 0000:19:01.0: LOOP UP detected (1 Gbps).
qla2xxx 0000:19:01.0: Topology - (Loop), Host Loop address 0x8
qla2xxx 0000:19:01.0: Failed to reserve interrupt 37 already in use.
qla2xxx: probe of 0000:19:01.0 failed with error -38




