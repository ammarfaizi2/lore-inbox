Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266299AbUA2TUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUA2TUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:20:19 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:16 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266299AbUA2TUN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:20:13 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpqarray update
Date: Thu, 29 Jan 2004 13:20:02 -0600
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E1596F@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray update
Thread-Index: AcPmltj4nyL6oxV8TBOM2km8RDrCvAABXfEA
From: "Wiran, Francis" <francis.wiran@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Greg KH" <greg@kroah.com>, "Hollis Blanchard" <hollisb@us.ibm.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jan 2004 19:20:03.0408 (UTC) FILETIME=[E5603500:01C3E69C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. I'll make a patch when the behaviour changes, as per Greg's:

>Yeah, I don't really like it either, but figured it was a 2.7 task to
>clean it up properly.

At 2.6.1, it still returns count.


> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Thursday, January 29, 2004 10:57 AM
> To: Wiran, Francis
> Cc: Greg KH; Hollis Blanchard; Marcelo Tosatti; Linux Kernel 
> Mailing List
> Subject: Re: [PATCH] cpqarray update
> 
> 
> Wiran, Francis wrote:
> > check for negative value? That's odd. The 
> pci_register_driver() in my
> > copy of 2.4.24 kernel (drivers/pci/pci.c) looks something like this:
> > 
> > {
> > 	count = 0;
> > 
> > 	for ....
> > 		count += foo();
> > 
> > 	return count;
> > }
> > 
> > 
> > Or will it change in the future? The patch that I sent was 
> based on what
> > is in the current kernel.
> 
> 
> Correct, Greg was referring to 2.6.x behavior of 
> pci_register_driver(), 
> which changed from 2.4.x.
> 
> 	Jeff
> 
> 
> 
> 
