Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbVKPUtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbVKPUtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVKPUtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:49:52 -0500
Received: from spirit.analogic.com ([204.178.40.4]:36364 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030473AbVKPUtv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:49:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <437B932F.3090607@davyandbeth.com>
References: <437B932F.3090607@davyandbeth.com>
X-OriginalArrivalTime: 16 Nov 2005 20:49:49.0781 (UTC) FILETIME=[494D4050:01C5EAEF]
Content-class: urn:content-classes:message
Subject: Re: virtual NICs
Date: Wed, 16 Nov 2005 15:49:44 -0500
Message-ID: <Pine.LNX.4.61.0511161540080.5251@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: virtual NICs
Thread-Index: AcXq70lzmvJnUChXQG+tR4pDAHrmfQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Davy Durham" <pubaddr2@davyandbeth.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2005, Davy Durham wrote:

> Curious question:
>
>  If I configure multiple IP addresses to a NIC, and assign 1.2.3.4 to
> eth0 and 5.6.7.8 to eth0:0 (a virtual NIC) is there extra work involved
> on the part of the CPU or memory or whatever in routing traffic via
> 5.6.7.8 than 1.2.3.4.. I mean does one IP have an advantage over the
> other in any sense?
>

Of course there is extra work! Any time something has to be checked
(filtered), there is the overhead of the filtering. In the case of
two or more IP addresses, the software has to perform an ARP on two
or more IPs. This means that it needs to "listen" for more queries.
Note that machines on Ethernet, communicate using their hardware-
addresses i.e., the "IEEE station address". But, the initial route
to the target machine needs to be set up by broadcasting an IP address,
thereby asking everybody on the LAN if the IP address belongs to them.
Hopefully only one machine answers. This sequence is called ARP
(address resolution protocol).

Adding more IP addresses is like adding more machines as far as
the source (perhaps a router) is concerned. Adding more IP addresses
to a single host is sometimes necessary, but it is not without
cost. Basically, don't do it unless it's necessary.

> Thanks,
>  Davy
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
