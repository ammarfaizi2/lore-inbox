Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVI3RHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVI3RHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVI3RHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:07:34 -0400
Received: from magic.adaptec.com ([216.52.22.17]:8598 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751221AbVI3RHe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:07:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Date: Fri, 30 Sep 2005 13:07:27 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Thread-Index: AcXF3sC1lEiP2iBXS9+mGa6OR529mQAAgZRA
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Tuikov, Luben" <Luben_Tuikov@adaptec.com>, <andrew.patterson@hp.com>
Cc: <dougg@torque.net>, "Linus Torvalds" <torvalds@osdl.org>,
       "Luben Tuikov" <ltuikov@yahoo.com>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the SAS BOF, I indicated that it would not be much trouble to
translate the CSMI handler in the aacraid driver to a similar sysfs
arrangement. If such info can be mined from a firmware based RAID card,
every driver should be able to do so. The spec writers really need to
consider rewriting SDI for sysfs (if they have not already) and move
away from an ABI.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Tuikov, Luben
Sent: Friday, September 30, 2005 12:47 PM
To: andrew.patterson@hp.com
Cc: dougg@torque.net; Linus Torvalds; Luben Tuikov; SCSI Mailing List;
Linux Kernel Mailing List
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx
into the kernel

On 09/30/05 12:26, Andrew Patterson wrote:
> 
> I talked to one of the authors of these specs.  SDI is an attempt to 
> create an open standard for the somewhat proprietary CSMI spec 
> developed by HP.  It is currently languishing in t10 due to the IOCTL 
> problem you describe below (the "no new IOCTL's" doctrine caught them 
> by surprise). There is some thought to going to a write()/read() on a 
> character device model, but this has various problems as well.

I think that read/write from a char device is going away too.

For this reason I showed the whole picture of the SAS
domain in sysfs _and_ created a binary file attr to send/receive SMP
requests/responses to control the domain and get attributes
("smp_portal" binary attr of each expander).

It is completely user space driven and a user space library
is simple to write.

See drivers/scsi/sas/expander_conf.c which is a user
space utility.  For the output see Announcement 3:
http://linux.adaptec.com/sas/Announce_2.txt or here:
http://marc.theaimsgroup.com/?l=linux-scsi&m=112629509318354&w=2

The code which implements it is very tiny, at the bottom
of drivers/scsi/sas/sas_expander.c
