Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbULHSJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbULHSJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbULHSFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:05:52 -0500
Received: from mail0.lsil.com ([147.145.40.20]:32949 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261287AbULHSEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:04:38 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CA8F@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Wed, 8 Dec 2004 12:56:07 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Wed, 2004-12-08 at 01:16, Bagalkote, Sreenivas wrote:
>> Adding a drive:- For application to use sysfs to scan newly added 
>> drive, it needs to know the HCTL (SCSI address - Host, 
>Channel, Target 
>> & Lun) of the drive. Driver is the only one that knows the mapping 
>> between a drive and the corresponding HCTL.
>
>The real way I'd like to handle this is via hotplug.  The 
>hotplug event would transmit the HCTL in the environment.  
>Whether the drive actually gets incorporated into the system 
>and where is user policy, so it's appropriate that it should 
>be in userland.

James, it is the application that is adding the drive. So it is not a
hotplug
event for the driver.

>
>This same infrastructure could be used by fibre channel login, 
>scsi enclosure events etc.
>
>We have some of the hotplug infrastructure in SCSI, but not 
>quite enough for this ... you'll need an additional API.
>
>> Removing a drive:- There is no sane way for the application 
>to map out 
>> drives to /dev/sd<x>. If application has a way of knowing 
>the HCTL of 
>> a deleted drive, then using that HCTL, it can match the 
>corresponding 
>> SCSI device name (/dev/sd<x>) and use sysfs to remove that drive.
>
>Since The sysfs device name contains H:C:T:L surely you can 
>just do a find on /sys?
>
>James
>
>

Thank you,
sreenivas
