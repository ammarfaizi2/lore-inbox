Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317276AbSGZHWr>; Fri, 26 Jul 2002 03:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSGZHWr>; Fri, 26 Jul 2002 03:22:47 -0400
Received: from babel.apana.org.au ([202.12.88.4]:7684 "EHLO babel.apana.org.au")
	by vger.kernel.org with ESMTP id <S317276AbSGZHWq>;
	Fri, 26 Jul 2002 03:22:46 -0400
Date: Fri, 26 Jul 2002 16:59:43 +1000
From: John August <johna@babel.apana.org.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 Fuji 1300 usb-storage problem
Message-ID: <20020726165943.B552@babel.apana.org.au>
References: <20020725102955.A700@babel.apana.org.au> <20020725162521.GA10675@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20020725162521.GA10675@sgi.com>; from nstraz@sgi.com on Thu, Jul 25, 2002 at 11:25:21AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 11:25:21AM -0500, Nathan Straz wrote:
> On Thu, Jul 25, 2002 at 10:29:55AM +1000, John August wrote:
> > Note that it does not get as far as identifying the partition table,
> > and the Model is indicated as FinePix 1400Zoom, when its in fact a 1300,
> > and previously it was "USB-DRIVEUNIT" as the model.
> 
> Maybe the 1300 doesn't have as broken a USB implementation as the 1400
> does.  In linux/drivers/usb/storage/unusual_devs.h there is an entry for
> the 1400.

Thanks Nathan,

I've changed things as suggested ...

Now, it does not even have the lines 

SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
sda: Write Protect is off

Let alone viewing the partitions.

You have :

hub.c: USB new device connect on bus1/2, assigned device number 3
scsi0 : SCSI emulation for USB Mass Storage devices
Vendor: FUJIFILM  Model: USB-DRIVEUNIT     Rev: 1.00
Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

As the total output.

It appears the original "USB-DRIVEUNIT" code in 2.4.2-2 was OK, or there's
some external problem in indentifying the sda device characteristics.

-- 
John August

