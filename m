Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTFPUdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTFPUdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:33:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12764 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264265AbTFPUdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:33:23 -0400
Date: Mon, 16 Jun 2003 13:49:09 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Alan Stern <stern@rowland.harvard.edu>
cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44L0.0306161526050.1350-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.44.0306161345570.908-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This doesn't provide any really good place to put device attributes that 
> are owned by the driver.  They can't go in
> 	/sysfs/class/pcmcia_socket/pcmcia_socket0/device/...
> because the driver doesn't own the device.  They can't go in
> 	/sysfs/class/pcmcia_socket/pcmcia_socket0/driver/...
> because they aren't attributes of the _driver_, they're attributes of the 
> _device_.  And they certainly aren't class attributes.
> 
> So where would you put them?  You'd have to create another subdirectory of
> 	/sysfs/class/pcmcia_socket/pcmcia_socket0/
> owned by the driver.  No really good name for this subdirectory spings 
> to mind, and it's still kind of awkward.  But doable.

What is wrong with putting them in 

/sysfs/class/pcmcia_socket/pcmcia_socket0/

? The driver owns that object. And, if it is device-specific feature, then 
it is likely related to what class the device belongs to, and is therefore 
relevant for that directory.


	-pat

