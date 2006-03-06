Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751914AbWCFQlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWCFQlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWCFQlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:41:08 -0500
Received: from bay101-f4.bay101.hotmail.com ([64.4.56.14]:25440 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751934AbWCFQlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:41:05 -0500
Message-ID: <BAY101-F4F3157DFC8ECF9BA96831DFE90@phx.gbl>
X-Originating-IP: [70.150.153.162]
X-Originating-Email: [jtreubig@hotmail.com]
In-Reply-To: <20060303153517.0e10f5d7.rdunlap@xenotime.net>
From: "John Treubig" <jtreubig@hotmail.com>
To: rdunlap@xenotime.net, hancockr@shaw.ca, albertcc@tw.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: CDROM support for Promise 20269
Date: Mon, 06 Mar 2006 10:40:58 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 06 Mar 2006 16:41:02.0614 (UTC) FILETIME=[C174D360:01C6413C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Randy and Robert.  Your suggestion fixed the problem.


From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Robert Hancock <hancockr@shaw.ca>, 
albertcc@tw.ibm.com,jtreubig@hotmail.com
CC: linux-kernel@vger.kernel.org, scsi <linux-scsi@vger.kernel.org>
Subject: Re: CDROM support for Promise 20269
Date: Fri, 3 Mar 2006 15:35:17 -0800

On Fri, 03 Mar 2006 17:25:54 -0600 Robert Hancock wrote:

 > John Treubig wrote:
 > > I've been working on a problem with Promise 20269 PATA adapter under
 > > LibATA that if I attach a CDROM drive, I can not see the drive.  The
 > > message log reports that the driver sees the device, but when I'm fully
 > > booted, there's no device available.
 >
 > ..
 >
 > > [  118.621489] scsi4 : pata_pdc2027x
 > > [  118.643926] ata1(1): WARNING: ATAPI is disabled, device ignored.
 >
 > Sounds like your problem there.. need to enable ATAPI in your
 > libata/PATA kernel configuration?

Please don't drop cc's etc.  Just use reply-to-all.

For John:  this means that you need to load libata with this option:
atapi_enabled=1
So if you build it into the kernel image, add this to the boot option:
   libata.atapi_enabled=1
or if you load it as a module, just add:  atapi_enabled=1
or you can edit the source file and change the variable to 1,
but that's the least preferable way IMO.

---
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


