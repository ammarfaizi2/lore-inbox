Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSGYA1s>; Wed, 24 Jul 2002 20:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSGYA1I>; Wed, 24 Jul 2002 20:27:08 -0400
Received: from babel.apana.org.au ([202.12.88.4]:5892 "EHLO babel.apana.org.au")
	by vger.kernel.org with ESMTP id <S318073AbSGYA05>;
	Wed, 24 Jul 2002 20:26:57 -0400
Date: Thu, 25 Jul 2002 10:29:55 +1000
From: John August <johna@babel.apana.org.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 Fuji 1300 usb-storage problem
Message-ID: <20020725102955.A700@babel.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to access the memory on a Fuji Fine Pix 1300. It works fine
on a 2.4.2-2 kernel, with the output to dmesg :

hub.c: USB new device connect on bus1/2, assigned device number 4
scsi0 : SCSI emulation for USB Mass Storage devices
Vendor: FUJIFILM  Model: USB-DRIVEUNIT     Rev: 1.00
Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
sda: Write Protect is off
sda: sda1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4

With the 2.4.18 kernel, I get :
hub.c: USB new device connect on bus1/2, assigned device number 3
scsi0 : SCSI emulation for USB Mass Storage devices
Vendor: Fujifilm  Model: FinePix 1400Zoom  Rev: 1000
Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
sda: Write Protect is off

And this is as far as it gets. I think I've once seen "unable to access
partition table". 

Note that it does not get as far as identifying the partition table,
and the Model is indicated as FinePix 1400Zoom, when its in fact a 1300,
and previously it was "USB-DRIVEUNIT" as the model.

As far as I can tell, all the needed modules are loaded and the problem
is not with kernel configuration. In any case, you would think accessing
the partition table is independent of filesystems and stuff.

Is this a dinky die bug ? Any thoughts for workarounds ?

I'm not on the list, please cc replies to me.

Thanks,

-- 
John August


