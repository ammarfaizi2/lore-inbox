Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946157AbWJSQSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946157AbWJSQSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946187AbWJSQSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:18:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946157AbWJSQSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:18:24 -0400
Date: Thu, 19 Oct 2006 09:18:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061019091816.e04ae8e7.akpm@osdl.org>
In-Reply-To: <p73r6x4bi5w.fsf@verdi.suse.de>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	<45364CE9.7050002@yahoo.com.au>
	<1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
	<45366515.4050308@yahoo.com.au>
	<1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
	<20061018154402.ef49874a.akpm@osdl.org>
	<1161212465.18117.35.camel@dyn9047017100.beaverton.ibm.com>
	<20061018162507.efa7b91a.akpm@osdl.org>
	<p73r6x4bi5w.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Oct 2006 14:32:11 +0200
Andi Kleen <ak@suse.de> wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Wed, 18 Oct 2006 16:01:05 -0700
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > 
> > > > Is the NMI watchdog ticking over?
> > > 
> > > I think so.
> > > 
> > > # dmesg | grep NMI
> > > ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> > > ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> > > ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> > > ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> > > testing NMI watchdog ... OK.
> > 
> > 
> > What does it say in /proc/interrupts?
> > 
> > The x86_64 nmi watchdog handling looks rather complex.
> > 
> > <checks a couple of x86-64 machines>
> > 
> > The /proc/interrutps NMI count seems to be going up by about
> > one-per-minute.  How odd.   Maybe you just need to wait longer.
> 
> That's consistent with a idle machine. The perfctr used by the nmi
> watchdog only increases when the CPU isn't halted and when it's idle
> it's not doing very much.  When something actually loops it should
> increase much faster though.
> 

ok..

What is the reason for not using an apic/lapic NMI source for the watchdog?
