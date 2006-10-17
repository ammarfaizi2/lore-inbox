Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWJQVQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWJQVQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWJQVQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:16:57 -0400
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:36566 "EHLO
	outbound1-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750727AbWJQVQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:16:56 -0400
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64: store Socket ID in phys_proc_id
Date: Tue, 17 Oct 2006 14:15:38 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D700@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64: store Socket ID in phys_proc_id
Thread-Index: AcbyLxInkP+qHLUgQ9yQJ8wsYTAiwwAAcjsQ
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
X-OriginalArrivalTime: 17 Oct 2006 21:15:39.0995 (UTC)
 FILETIME=[65AF62B0:01C6F231]
X-WSS-ID: 692B98760CK4531231-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen [mailto:ak@muc.de] 

>> Socket ID is 0 for first Physical processor?
>It must just be some unique ID for each socket.

For dual core, if I lift AP's APIC ID and no touch BSP's APIC ID.
For example, BSP is still 0, and second core is 0x11.
The phys_proc_id will be 0 for BSP, and 8 for second core.
So I suggest you to use initial APIC ID to get socket id instead of APIC
ID.

YH


