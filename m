Return-Path: <linux-kernel-owner+w=401wt.eu-S1751600AbXAHRYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbXAHRYg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 12:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXAHRYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 12:24:36 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:6612 "EHLO
	outbound1-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751598AbXAHRYe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 12:24:34 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
 check_timer fails.
Date: Mon, 8 Jan 2007 09:16:32 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907360@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
 check_timer fails.
Thread-Index: AcczP8NNzpTt9J57QD+KkxpJlyA+XgAB52MQ
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com, "Linus Torvalds" <torvalds@osdl.org>
cc: "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2007 17:16:34.0261 (UTC)
 FILETIME=[BF3F5850:01C73348]
X-WSS-ID: 69BCA3FB1WC4134937-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Monday, January 08, 2007 8:11 AM
To: Linus Torvalds
Cc: Tobias Diedrich; Lu, Yinghai; Andrew Morton; Adrian Bunk; Andi
Kleen; Linux Kernel Mailing List
Subject: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when
check_timer fails.

>I have tested this on an Nvidia board that reports that apic 0 pin 2
>works when it does not and this code successfully programs apic 0 pin 0
>into ExtINT mode.

For some CK804 boards, BIOS forget set to 8254 timer to apic0/pin2, and
still leave it at apic0/pin0. but mptable and acpi said 8254 timer is to
apic0/pin2. At such case we should try apic0/pin0 with INT mode instead
of ExtINT mode.

YH




