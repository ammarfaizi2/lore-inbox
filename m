Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUA2QkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUA2QkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:40:10 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:10250 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S266237AbUA2QkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:40:03 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpqarray update
Date: Thu, 29 Jan 2004 10:39:48 -0600
Message-ID: <CBD6B29E2DA6954FABAC137771769D6504E1596E@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpqarray update
Thread-Index: AcPl97MDYCr9uBZ6RfOTYAJ7P0onNQAjWbKw
From: "Wiran, Francis" <francis.wiran@hp.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Hollis Blanchard" <hollisb@us.ibm.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jan 2004 16:39:50.0247 (UTC) FILETIME=[837C3F70:01C3E686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Wednesday, January 28, 2004 5:29 PM
> To: Wiran, Francis
> Cc: Hollis Blanchard; Marcelo Tosatti; Jeff Garzik; Linux 
> Kernel Mailing List
> Subject: Re: [PATCH] cpqarray update
> 
> 
> On Wed, Jan 28, 2004 at 05:10:29PM -0600, Wiran, Francis wrote:
> > 
> > Ok. Here's the patch for that. At least until 
> vio_module_init comes :)
> 
> Heh, you didn't actually try that patch, did you?
> 
> (hint, you need to check for a negative value...)
> 
> greg k-h
> 

check for negative value? That's odd. The pci_register_driver() in my
copy of 2.4.24 kernel (drivers/pci/pci.c) looks something like this:

{
	count = 0;

	for ....
		count += foo();

	return count;
}


Or will it change in the future? The patch that I sent was based on what
is in the current kernel.




Just for clarification:
I sent two patches yesterday (I should've numbered them, sorry I
forgot), since they address different issues and the driver registration
issue is being discussed right now.
First patch was cpqarray_eisa_detect_fix.patch, second was
cpqarray_pci_unregister.patch
