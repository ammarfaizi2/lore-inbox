Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVCIRpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVCIRpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVCIRpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:45:01 -0500
Received: from minimail.digi.com ([66.77.174.15]:53621 "EHLO minimail.digi.com")
	by vger.kernel.org with ESMTP id S262123AbVCIRmb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:42:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ patch 6/7] drivers/serial/jsm: new serial device driver
Date: Wed, 9 Mar 2005 11:42:31 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9E9@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ patch 6/7] drivers/serial/jsm: new serial device driver
Thread-Index: AcUkzektfT08CmaEQtmGs/jGEM9ejgAAA1Rw
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Wen Xiong" <wendyx@us.ibm.com>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wendy, Greg, all,

If IBM intends on our DPA management program to work for the JSM
products,
the ioctls are needed.

DPA support is a requirement for all Digi drivers, so it would
not be possible for me to remove them from my "dgnc" version
of the driver.

For the JSM driver, its up to you whether you feel its needed or not.

However, I would like to mention that the DIGI drivers that currently
reside in the kernel sources *do* reserve that ioctl space,
and is acknowledged by "Documentation/ioctl-number.txt":
> d'     F0-FF   linux/digi1.h

I understand that the list is not a reservation list,
but a current list of potential ioctl conflicts...

But the JSM driver sure doesn't add any new ioctl ranges,
or cause any new conflicts that didn't already exist.

Scott



-----Original Message-----
From: Wen Xiong [mailto:wendyx@us.ibm.com] 
Sent: Wednesday, March 09, 2005 11:32 AM
To: Greg KH
Cc: Kilau, Scott; linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver


Greg KH wrote:

>On Wed, Mar 09, 2005 at 10:50:04AM -0500, Wen Xiong wrote:
>  
>
>>+/* Ioctls needed for dpa operation */
>>+#define DIGI_GETDD	('d'<<8) | 248		/* get driver info
*/
>>+#define DIGI_GETBD	('d'<<8) | 249		/* get board info
*/
>>+#define DIGI_GET_NI_INFO ('d'<<8) | 250		/*
nonintelligent state snfo */
>>    
>>
>
>Hm, new ioctls still?...
>
>And the structures you are attempting to access through these ioctls
are
>incorrect, so if you are still insisting you need them, at least make
>the code work properly :(
>
>thanks,
>
>greg k-h
>
>  
>
Hi Scott,

The above three ioctls are for dpa/managment. If I removed these ioctls,

I have to remove jsm_mgmt.c(patch5.jasmine).
Do you mind I remove jsm_mgmt.c code now? From my side, I  don't think I

need them now.

Maybe we can have a solution in the kernel as Russell and Greg said
later.

Thanks,
wendy

