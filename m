Return-Path: <linux-kernel-owner+w=401wt.eu-S1750736AbXAHVJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbXAHVJe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbXAHVJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:09:34 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:40967 "EHLO
	outbound4-fra-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736AbXAHVJd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:09:33 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH 1/4] x86_64 io_apic: Implement remove_pin_to_irq
Date: Mon, 8 Jan 2007 13:09:19 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490736C@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/4] x86_64 io_apic: Implement remove_pin_to_irq
Thread-Index: AcczPPdYtvPRagMXTcWnQes7EWQjoQAK6tbg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com, "Linus Torvalds" <torvalds@osdl.org>
cc: "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2007 21:09:19.0972 (UTC)
 FILETIME=[4375BA40:01C73369]
X-WSS-ID: 69BC6D751WC4152701-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Monday, January 08, 2007 7:50 AM
To: Linus Torvalds
Cc: Tobias Diedrich; Lu, Yinghai; Andrew Morton; Adrian Bunk; Andi
Kleen; Linux Kernel Mailing List
Subject: [PATCH 1/4] x86_64 io_apic: Implement remove_pin_to_irq

+static void remove_pin_to_irq(unsigned int irq, int apic, int pin)
+{
+	struct irq_pin_list *entry = irq_2_pin + irq;

You may need to update add_pin_to_irq to avoid multi entries for irq 0.

YH


