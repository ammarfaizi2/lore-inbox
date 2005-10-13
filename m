Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVJMUDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVJMUDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVJMUDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:03:31 -0400
Received: from fmr13.intel.com ([192.55.52.67]:21377 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932438AbVJMUDa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:03:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Date: Thu, 13 Oct 2005 16:03:17 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3004DDDA67@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Thread-Index: AcXQK/UAxrciNJdkRrac1/3GPORGIAABCqOA
From: "Brown, Len" <len.brown@intel.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <iss_storagedev@hp.com>,
       "Jakub Jelinek" <jj@ultra.linux.cz>, "Frodo Looijaard" <frodol@dds.nl>,
       "Jean Delvare" <khali@linux-fr.org>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Jens Axboe" <axboe@suse.de>, "Roland Dreier" <rolandd@cisco.com>,
       "Sergio Rozanski Filho" <aris@cathedrallabs.org>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Pierre Ossman" <drzeus-wbsd@drzeus.cx>,
       "Carsten Gross" <carsten@sol.wh-hms.uni-ulm.de>,
       "Greg Kroah-Hartman" <greg@kroah.com>,
       "David Hinds" <dahinds@users.sourceforge.net>,
       "Vinh Truong" <vinh.truong@eng.sun.com>,
       "Mark Douglas Corner" <mcorner@umich.edu>,
       "Michael Downey" <downey@zymeta.com>,
       "Antonino Daplas" <adaplas@pol.net>,
       "Ben Gardner" <bgardner@wabtec.com>
X-OriginalArrivalTime: 13 Oct 2005 20:01:26.0829 (UTC) FILETIME=[E4F66DD0:01C5D030]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: ACPI files

Acked-by: Len Brown <len.brown@intel.com>

thanks,
-Len

ps.  I'm okay with reducing the routine below
to a 2-liner if you're so inclined.

>--- linux-2.6.14-rc4-orig/drivers/acpi/container.c	
>2005-10-11 22:41:04.000000000 +0200
>+++ linux-2.6.14-rc4/drivers/acpi/container.c	2005-10-12 
>16:31:11.000000000 +0200
>@@ -118,11 +118,9 @@ static int acpi_container_remove(struct 
> {
> 	acpi_status status = AE_OK;
> 	struct acpi_container *pc = NULL;
>-	pc = (struct acpi_container *)acpi_driver_data(device);
>-
>-	if (pc)
>-		kfree(pc);
> 
>+	pc = (struct acpi_container *)acpi_driver_data(device);
>+	kfree(pc);
> 	return status;
> }
