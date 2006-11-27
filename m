Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933647AbWK0VrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933647AbWK0VrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933766AbWK0VrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:47:07 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:6600 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S933647AbWK0VrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:47:04 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH 2/3] x86: remove duplicated parser for "pci=noacpi"
Date: Mon, 27 Nov 2006 13:46:52 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907241@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3] x86: remove duplicated parser for "pci=noacpi"
Thread-Index: AccRukkdBp41KfC3TO2ya/BJ4Ka9dQAseIFA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
cc: "Andrew Morton" <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, "Greg KH" <gregkh@suse.de>,
       "Len Brown" <len.brown@intel.com>
X-OriginalArrivalTime: 27 Nov 2006 21:46:54.0174 (UTC)
 FILETIME=[8DB827E0:01C7126D]
X-WSS-ID: 697583441WC1553864-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Sunday, November 26, 2006 4:22 PM

>Are you sure it's correct? The drivers/pci pci= parsing
>isn't early and there tend to be nasty ordering issues.
>I can't see where it would go wrong here, but it probably
>needs very careful double checking.

I double check that, we don't need the parser in
arch/i386/kernel/acpi/boot.c for 
pci=noapci.

Actually, pcibios_setup in arch/i386/kernel/pci/common.c that process
pci=noacpi will be
called by pci_setup in drivers/pci/pci.c, and 
early_param("pci", pci_setup);

YH


