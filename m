Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVCaLRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVCaLRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCaLRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:17:13 -0500
Received: from general.keba.co.at ([193.154.24.243]:10681 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261340AbVCaLPh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:15:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.11, USB: High latency?
Date: Thu, 31 Mar 2005 13:15:23 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231CF@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, USB: High latency?
Thread-Index: AcU1QOmYmgzgBJegTNu7pzr78CzZrAAoM+1Q
From: "kus Kusche Klaus" <kus@keba.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: <linux-usb-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The latencies are almost certainly caused by the USB host controller 
> driver.  I'm planning improvements to uhci-hcd which should 
> help reduce 
> the latency, but it will still be on the large side.  And I 
> won't have 
> time to write the changes to the driver for several months.

Any numbers about the expected "large side"? 
We would need <30 microseconds irq latency,
and <<1 milliseconds rt application latency.

> The best solution is to stop using uhci-hcd.  Get a PCI card 
> with an OHCI 
> or EHCI (high-speed) controller.  They do much more work in hardware, 
> reducing the amount of time the driver needs to spend with interrupts 
> disabled.

The hardware is invariable. It is an embedded system with no PCI slots.

And it seems to be possible with UHCI, 
because vxWorks allows USB stick transfers in operation without
missing latency requirements.

I do not require rt on the USB, it may block its own irq as long as
it likes, but it should not affect other irqs.

-- 
Klaus Kusche
Entwicklung Software - Steuerung
Software Development - Control

KEBA AG
A-4041 Linz
Gewerbepark Urfahr
Tel +43 / 732 / 7090-3120
Fax +43 / 732 / 7090-8919
E-Mail: kus@keba.com
www.keba.com
 
