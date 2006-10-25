Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWJYS1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWJYS1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 14:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWJYS1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 14:27:45 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:10186 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1030397AbWJYS1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 14:27:43 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64 irq: reset more to default when clear
 irq_vector for destroy_irq
Date: Wed, 25 Oct 2006 09:40:35 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D763@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64 irq: reset more to default when clear
 irq_vector for destroy_irq
Thread-Index: Acb4KQP9X/ULutS6SCmEe900qJWIUQAKwUcg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
cc: "Andi Kleen" <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Oct 2006 16:40:36.0178 (UTC)
 FILETIME=[4BF2C320:01C6F854]
X-WSS-ID: 69214C0E1X4328487-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

I only found ht_irq and msi call destroy_irq. How about io_apic? 

YH

-----Original Message-----
From: Muli Ben-Yehuda [mailto:muli@il.ibm.com] 
Sent: Wednesday, October 25, 2006 4:30 AM
To: Lu, Yinghai
Cc: Andi Kleen; Eric W. Biederman; Andrew Morton; Linux Kernel Mailing
List
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear
irq_vector for destroy_irq

On Tue, Oct 24, 2006 at 08:46:31PM -0700, Yinghai Lu wrote:
> resend with gmail.
> 
> Clear the irq releated entries in irq_vector, irq_domain and
vector_irq
> instead of clearing irq_vector only. So when new irq is created, it
> could reuse that vector. (actually is the second loop scanning from
> FIRST_DEVICE_VECTOR+8). This could avoid the vectors are used up
> with enough module inserting and removing
> 
> Cc: Eric W. Biedierman <ebiederm@xmission.com>
> Signed-off-By: Yinghai Lu <yinghai.lu@amd.com>

I hope I'm testing the right patch... this one boots and works fine.

Cheers,
Muli




