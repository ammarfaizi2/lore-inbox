Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVCOMfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVCOMfN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVCOMfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:35:13 -0500
Received: from aun.it.uu.se ([130.238.12.36]:29097 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261197AbVCOMfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:35:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16950.54895.527127.21123@alkaid.it.uu.se>
Date: Tue, 15 Mar 2005 13:34:55 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: enabling IOAPIC on C3 processor?
In-Reply-To: <5a2cf1f6050315040956a512a6@mail.gmail.com>
References: <5a2cf1f6050315040956a512a6@mail.gmail.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste writes:
 > I have a VIA Epia M10000 board that crashes very badly (and pretty
 > often, especially when using DMA). I want to fix that.
 > 
 > Serial console + magic SysRQ didn't help so I am going the nmi
 > watchdog way. But in order to have nmi watchdog I need APIC, right?
 > 
 > The C3 processor seems to support IOAPIC.
 > (http://www.via.com.tw/en/products/processors/c3/specs.jsp)
 > 
 > But:
 > - I don't see anything in the BIOS related to APIC. 
 > - grep APIC /lib/modules/`uname -r`/build/.config shows me that all
 > APIC options are 'y'.
 > - dmesg | grep APIC tells me "no local APIC present or hardware disabled".
 > - adding lapic kernel parameter doesn't change that. 
 > - and of course, nmi_watchdog=1 or 2 gives me NMI count 0 in /proc/interrupts.
 > 
 > Did I miss something when it comes to enabling IOAPIC support on C3 processor?

Unless you have a pre-release engineering part for a future product,
then your C3 has no local APIC, and hence no I/O APIC functionality.

I know some C3 specs pages list I/O APIC support, but if you look in
the datasheets for current products you find zero APIC support.
