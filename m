Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVEZVjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVEZVjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVEZViu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:38:50 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:4537 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261766AbVEZVgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:36:31 -0400
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell
	BIOS update driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Abhay_Salunke@Dell.com, linux-kernel@vger.kernel.org, ranty@debian.org
In-Reply-To: <20050526203757.GA18723@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED399@ausx2kmpc115.aus.amer.dell.com>
	 <20050526203757.GA18723@kroah.com>
Content-Type: text/plain
Date: Thu, 26 May 2005 23:36:20 +0200
Message-Id: <1117143380.12036.71.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhay,

> > static int __init dcdrbu_init(void)
> > {
> >         int rc = 0;
> >         const struct firmware *fw;
> > 
> >         device_initialize(&rbu_device_type);
> >         device_initialize(&rbu_device);
> > 
> >         strncpy(rbu_device.bus_id,"dell_rbu.bin", BUS_ID_SIZE);
> >         strncpy(rbu_device_type.bus_id,"dell_rbu1.bin", BUS_ID_SIZE);
> > 
> >         rc = request_firmware(&fw, "dell_rbu_type", &rbu_device_type);
> 
> Try registering the device with sysfs first.

and then you use the same device for both calls and put the firmware
names into the request_firmware() calls. This is the filename you are
going to request from userspace.

Regards

Marcel


