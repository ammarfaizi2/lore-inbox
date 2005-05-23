Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVEWPAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVEWPAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEWPAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:00:39 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:59574 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261881AbVEWO74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:59:56 -0400
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell
	BIOS update driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Abhay_Salunke@Dell.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED388@ausx2kmpc115.aus.amer.dell.com>
References: <367215741E167A4CA813C8F12CE0143B3ED388@ausx2kmpc115.aus.amer.dell.com>
Content-Type: text/plain
Date: Mon, 23 May 2005 16:59:38 +0200
Message-Id: <1116860378.30044.92.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhay,

> > Also, what's wrong with using the existing firmware interface in the
> > kernel?
> request_firmware requires the $FIRMWARE env to be populated with the
> firmware image name or the firmware image name needs to be hardcoded
> within  the call to request_firmware.

the latter one. Don't mess with the $FIRMWARE env, because this comes
from the kernel hotplug call.

> Since the user is free to change
> the BIOS update image at will, it may not be possible if we use
> $FIRMWARE also I am not sure if this env variable might be conflicting
> to some other driver.

I am not quite sure what's the problem here. Tell the kernel what
firmware image to request. Something like

	echo "firmware-filename" > /sys/firmware/dell_rbu/download

Regards

Marcel


