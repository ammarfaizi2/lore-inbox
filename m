Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265583AbUAGRCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUAGRCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:02:34 -0500
Received: from c-24-15-219-142.client.comcast.net ([24.15.219.142]:52667 "EHLO
	rekl.yi.org") by vger.kernel.org with ESMTP id S265583AbUAGRC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:02:29 -0500
Date: Wed, 7 Jan 2004 11:02:15 -0600 (CST)
From: lk@rekl.yi.org
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: KM266/VT8235, USB2.0 and problems
In-Reply-To: <20040106192543.GC11989@kroah.com>
Message-ID: <Pine.LNX.4.58.0401071059030.27133@rekl.yi.org>
References: <Pine.LNX.4.58.0401042314160.18200@rekl.yi.org>
 <20040105081226.GA14177@kroah.com> <Pine.LNX.4.58.0401051045270.30821@rekl.yi.org>
 <20040105172306.GB21531@kroah.com> <Pine.LNX.4.58.0401052145520.32347@rekl.yi.org>
 <20040106192543.GC11989@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Greg KH wrote:

> Can you enable CONFIG_USB_STORAGE_DEBUG and send the debug log to the
> linux-usb-devel mailing list for when this happens?  The people there
> should be able to help you out.
> 

Ok, I enabled that and the SCSI option.  Here's what I get:

Jan  7 09:04:10 axp kernel: hub 1-0:1.0: new USB device on port 3, 
assigned address 6
Jan  7 09:04:10 axp usb.agent[4754]: ... no modules for USB product 
ea0/2168/200
Jan  7 09:04:10 axp kernel: scsi0 : SCSI emulation for USB Mass Storage 
devices
Jan  7 09:04:10 axp kernel:   Vendor: MicroAdv  Model: QuickiDrive128M   
Rev: 2.00
Jan  7 09:04:10 axp kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 02
Jan  7 09:04:10 axp scsi.agent[4788]: how to add device type= at 
/devices/pci0000:00/0000:00:10.3/usb1/1-3/1-3:1.0/host0/0:0:0:0 ??
Jan  7 09:04:10 axp kernel: sda: Unit Not Ready, sense:
Jan  7 09:04:10 axp kernel: Current : sense key Unit Attention
Jan  7 09:04:10 axp kernel: Additional sense: Not ready to ready change, 
medium may have changed
Jan  7 09:04:10 axp kernel: sda : READ CAPACITY failed.
Jan  7 09:04:10 axp kernel: sda : status=1, message=00, host=0, driver=08
Jan  7 09:04:10 axp kernel: Current sd: sense key Unit Attention
Jan  7 09:04:10 axp kernel: Additional sense: Not ready to ready change, 
medium may have changed
Jan  7 09:04:11 axp kernel: sda: Write Protect is off
Jan  7 09:04:11 axp kernel:  sda:<7>usb-storage: queuecommand called
Jan  7 09:04:11 axp kernel:  sda1
Jan  7 09:04:11 axp kernel: Attached scsi removable disk sda at scsi0, 
channel 0, id 0, lun 0
Jan  7 09:04:11 axp kernel: Attached scsi generic sg0 at scsi0, channel 0, 
id 0, lun 0,  type 0
Jan  7 09:09:05 axp kernel: SCSI error : <0 0 0 0> return code = 0x70000
Jan  7 09:09:05 axp kernel: end_request: I/O error, dev sda, sector 7552


Also, the full dmesg and .config are available at 
http://rekl.no-ip.org/~lk/

The problem is that the USB2.0 flash drive doesn't work after a few 
accesses on my KM266/8235 based machine.  It works fine on my laptop, 
which also has USB2.0.

Any suggestions?

Thanks.
 
