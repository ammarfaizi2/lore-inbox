Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSLMCLT>; Thu, 12 Dec 2002 21:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSLMCLT>; Thu, 12 Dec 2002 21:11:19 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:977
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261973AbSLMCLS>; Thu, 12 Dec 2002 21:11:18 -0500
Date: Thu, 12 Dec 2002 21:21:51 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
In-Reply-To: <200212121809.43698.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.50.0212122116260.6931-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0212112105490.14901-100000@montezuma.mastecende.com>
 <200212121809.43698.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, James Cleverdon wrote:

> On Thursday 12 December 2002 05:44 pm, Zwane Mwaikambo wrote:
> > Hi,
> > 	I've got an 32x SMP system which has an xAPIC but utilises flat
> > addressing. This patch is to rename what was formerly x86_summit to
> > x86_xapic (just to avoid confusion) and then select mask depending on
> > that.
> >
> > Untested/uncompiled patch
>
> Hi Zwane,
>
> How can you have a 32-way SMP system with flat addressing?  There are only 8
> bits in the destination address field.  Even if you work around that by
> assigning a set of CPUs to each dest addr bit, there can only be 15 physical
> APIC IDs in flat mode.  To get to 32 you must switch into clustered mode.
>
> Please tell me more.  I'm intrigued how this can be done.

Hi James,
	with the xAPIC we can use the 8bit address space everywhere in
physical destination mode. For example the ICR now has an 8bit space for
destination.

"Specifies the target processor or processors. This field is only used
when the destination shorthand field is set to 00B. If the destination
mode is set to physical, then bits 56 through 59 contain the APIC ID of
the target processor for Pentium and P6 family processors and bits 56
through 63 contain the APIC ID of the target processor the for Pentium 4
and Intel Xeon processors. If the destination mode is set to logical, the
interpretation of the 8-bit destination field depends on the settings of
the DFR and LDR registers of the local APICs in all the processors in the
system (see Section 8.6.2.,  Determining IPI Destination )."
	- System Developer's Manual vol3 p291

Regards,
	Zwane
-- 
function.linuxpower.ca
