Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVHUBzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVHUBzx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 21:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVHUBzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 21:55:53 -0400
Received: from mx1.rowland.org ([192.131.102.7]:6928 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750760AbVHUBzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 21:55:53 -0400
Date: Sat, 20 Aug 2005 21:55:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Norbert Preining <preining@logic.at>
cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: Problems with connect/disconnect cycles
In-Reply-To: <20050821013257.GA31597@gamma.logic.tuwien.ac.at>
Message-ID: <Pine.LNX.4.44L0.0508202151130.1374-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2005, Norbert Preining wrote:

> Hi USB developers, hi Andrew!
> 
> On Mon, 21 Mär 2005, preining wrote:
> > Dear usb developers, dear Andrew!
> > 
> > I found that my builtin sd card reader connected via USB port
> > experiences several connect/reconnect cycles every time I boot.
> > 
> > I am using 2.6.11-mm4.
> 
> Same now with 2.6.13-rc6-mm1. This time it got really bad:
> 
> Aug 20 14:00:19 gandalf vmunix: usb 2-2: USB disconnect, address 2
> Aug 20 14:00:19 gandalf kernel: usb 2-2: new full speed USB device using uhci_hcd and address 3
> Aug 20 14:00:19 gandalf kernel: scsi1 : SCSI emulation for USB Mass Storage devices
> Aug 20 14:00:19 gandalf kernel: usb-storage: device found at 3
> Aug 20 14:00:19 gandalf kernel: usb-storage: waiting for device to settle before scanning
> Aug 20 14:00:21 gandalf usb.agent[6109]:      usb-storage: already loaded
> Aug 20 14:00:24 gandalf vmunix:   Vendor: Generic   Model: Flash R/W         Rev: 2002
> Aug 20 14:00:24 gandalf vmunix:   Type:   Direct-Access                      ANSI SCSI revision: 02
> Aug 20 14:00:24 gandalf vmunix: Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
> Aug 20 14:00:24 gandalf kernel: usb-storage: device scan complete
> Aug 20 14:00:26 gandalf scsi.agent[6154]:      sd_mod: loaded successfully (for disk)

> Unfortunately I cannot in any way track down this problem to specific
> kernels, or specific work situations. It sometimes happens, sometimes
> not. 
> 
> If anyone has any idea how to debug such a stupid problem, I would be
> glad. 

Speaking in broad terms, it's normal to see new device connection and
configuration messages like the ones above when a USB device is plugged in
to your computer.  What's not normal is to see disconnects.  So you should
be concentrating on what happens just before the log entries you posted --
why is the card reader disconnecting?  Turning on CONFIG_USB_DEBUG may 
provide more help.

Alan Stern

