Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272864AbTHKR1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272874AbTHKR1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:27:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52971 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272864AbTHKRYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:24:25 -0400
Message-ID: <3F37D13D.7080309@pobox.com>
Date: Mon, 11 Aug 2003 13:24:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Intel ICH5 APIC, ACPI problems in 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a couple uniprocessor ICH5 systems from different vendors, with 
similar behavior:

2.6:  HyperThreading works, ACPI works, all irqs properly routed

2.4:  HT works only works with ACPI enabled, but,
       ACPI kills the irq routing for the external PCI slots.
       pci=noacpi or whatever doesn't work.  !CONFIG_ACPI + "noapic"
       fixes irq routing, but then no HT sibling appears.

It seems like kernel 2.4.22-rc is missing some ACPI and possibly some 
APIC fixes?

	Jeff



