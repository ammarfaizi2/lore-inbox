Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753868AbWKFWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbWKFWSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbWKFWSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:18:45 -0500
Received: from outbound-red.frontbridge.com ([216.148.222.49]:51608 "EHLO
	outbound2-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1753868AbWKFWSo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:18:44 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
Date: Mon, 6 Nov 2006 14:15:23 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490719C@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
Thread-Index: AccB76iQA5hCbNAARyOEuq8sJzO/XgAAAx3g
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>
cc: "Greg KH" <gregkh@suse.de>, "Andi Kleen" <ak@suse.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Nov 2006 22:15:24.0545 (UTC)
 FILETIME=[0E814F10:01C701F1]
X-WSS-ID: 69516C761AO1093171-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
>I don't really understand what this patch does.
>We have a PCI device with a 64-bit BAR and the size is also 64-bit and
is
>larger than 4G, yes?

Yes

>But the code appears to already be attempting to handle such devices. 
>Confused.

The old code will 
Try to calculate the sz from lo 32 bit addr reg, and sz is 0 if the 64
bit resource size if 4G above, so it will continue can skip that
register, and it will go on try to treat the hi 32bit addr reg as
another 32 bit resource addr reg.

YH





