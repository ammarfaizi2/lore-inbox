Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751539AbWJRXZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbWJRXZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWJRXZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:25:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24809 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751539AbWJRXZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:25:19 -0400
Date: Wed, 18 Oct 2006 16:25:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061018162507.efa7b91a.akpm@osdl.org>
In-Reply-To: <1161212465.18117.35.camel@dyn9047017100.beaverton.ibm.com>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	<45364CE9.7050002@yahoo.com.au>
	<1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
	<45366515.4050308@yahoo.com.au>
	<1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
	<20061018154402.ef49874a.akpm@osdl.org>
	<1161212465.18117.35.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 16:01:05 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> > Is the NMI watchdog ticking over?
> 
> I think so.
> 
> # dmesg | grep NMI
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> testing NMI watchdog ... OK.


What does it say in /proc/interrupts?

The x86_64 nmi watchdog handling looks rather complex.

<checks a couple of x86-64 machines>

The /proc/interrutps NMI count seems to be going up by about
one-per-minute.  How odd.   Maybe you just need to wait longer.

Or try booting with nmi_watchdog=2 (Documentation/x86_64/boot-options.txt).

There's an empty directory /sys/devices/system/lapic_nmi/lapic_nmi0/.  I
wonder what that does?

