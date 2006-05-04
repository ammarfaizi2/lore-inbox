Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWEDQmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWEDQmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWEDQmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:42:19 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:45831 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1030215AbWEDQmT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:42:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 4 May 2006 11:42:09 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BBF@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZvj+3cUNJ/67FZTaabyEaNx8cUSQAAHvvQAAIXkFA=
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Brown, Len" <len.brown@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 04 May 2006 16:42:10.0820 (UTC) FILETIME=[B07B7C40:01C66F99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I think what we can do in the short term is to make these 
> workarounds not have any effect on the systems which don't 
> need them.  This means searching like gsi_irq_sharing() does, 
> instead of always compressing like mp_register_gsi() does.  
> It also means not printing dmesg about vector sharing when no 
> sharing is actually happening.
> 
OK that means Kimball should test the kernel with gsi_irq_sharing() and
without the compression code in mp_register_gsi() which should work for
him (and certainly for ES7000). I am not sure about VIA though, since
they still want PCI IRQs below 16. That means moving the VIA workaround
(and subsequently the one for Stratus :) to gsi_irq_sharing() I suspect.

--Natalie
