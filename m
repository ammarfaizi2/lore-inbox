Return-Path: <linux-kernel-owner+w=401wt.eu-S1762932AbWLKQ72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762932AbWLKQ72 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762935AbWLKQ72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:59:28 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47608 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760656AbWLKQ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:59:25 -0500
Message-ID: <457D8E69.5050906@garzik.org>
Date: Mon, 11 Dec 2006 11:59:21 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: "Darrick J. Wong" <djwong@us.ibm.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Douglas Gilbert <dougg@torque.net>
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org>	 <4574B004.6030606@us.ibm.com>  <457D8637.5070707@garzik.org> <1165855489.2791.7.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1165855489.2791.7.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Mon, 2006-12-11 at 11:24 -0500, Jeff Garzik wrote:
>> Darrick J. Wong wrote:
>>> The Quantum GoVault SATAPI removable disk device returns ATA_ERR in
>>> response to a REPORT LUNS packet.  If this happens to an ATAPI device
>>> that is attached to a SAS controller (this is the case with sas_ata),
>>> the device does not load because SCSI won't touch a "SCSI device"
>>> that won't report its LUNs.  Since most ATAPI devices don't support
>>> multiple LUNs anyway, we might as well fake a response like we do for
>>> ATA devices.
>>>
>>> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
>> I'm leaning towards applying this, perhaps with a module option that 
>> allows experimenters to revert back to the older behavior.
>>
>> Any chance you could be talked into tackling some of the SAT 
>> translation-related items Doug G mentioned?  I'm almost certain there 
>> are some info pages we should be returning, but are not, at the very least.
> 
> I thought we were closing in on agreeing that the SPC/MMC
> inconsistencies made this the correct candidate fix.

that works for me...

	Jeff



