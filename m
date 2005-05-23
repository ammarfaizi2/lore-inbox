Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVEWPhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVEWPhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVEWPhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:37:14 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:6259 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261888AbVEWPhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:37:03 -0400
X-IronPort-AV: i="3.93,129,1115010000"; 
   d="scan'208"; a="264159881:sNHT36291106"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Date: Mon, 23 May 2005 10:36:37 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED389@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Thread-Index: AcVfqBe6jorxhMq7RAy9IO8zV3sy8wABKqfA
From: <Abhay_Salunke@Dell.com>
To: <marcel@holtmann.org>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 23 May 2005 15:36:37.0696 (UTC) FILETIME=[353AE400:01C55FAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Monday, May 23, 2005 10:00 AM
> To: Salunke, Abhay
> Cc: greg@kroah.com; linux-kernel@vger.kernel.org; akpm@osdl.org;
Domsch,
> Matt
> Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new
> DellBIOS update driver
> 
> Hi Abhay,
> 
> > > Also, what's wrong with using the existing firmware interface in
the
> > > kernel?
> > request_firmware requires the $FIRMWARE env to be populated with the
> > firmware image name or the firmware image name needs to be hardcoded
> > within  the call to request_firmware.
> 
> the latter one. Don't mess with the $FIRMWARE env, because this comes
> from the kernel hotplug call.
> 
> > Since the user is free to change
> > the BIOS update image at will, it may not be possible if we use
> > $FIRMWARE also I am not sure if this env variable might be
conflicting
> > to some other driver.
> 
> I am not quite sure what's the problem here. Tell the kernel what
> firmware image to request. Something like
> 
> 	echo "firmware-filename" > /sys/firmware/dell_rbu/download
> 
Looks like request_firmware is causing lots of changes in my code. For
now I would just focus on getting the size parameters in normal sysfs
attribute and do request_firmware some time later as a separate patch.

Thanks,
Abhay
