Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275285AbTHGKFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275286AbTHGKFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:05:18 -0400
Received: from port-212-202-27-44.reverse.qsc.de ([212.202.27.44]:29599 "EHLO
	camelot.fbunet.de") by vger.kernel.org with ESMTP id S275285AbTHGKFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:05:08 -0400
From: Fridtjof Busse <fbusse@gmx.de>
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Aug 2003 12:05:06 +0200
X-OS: Linux on i686
MIME-Version: 1.0
Content-Disposition: inline
Cc: marcelo@conectiva.com.br
Subject: Re: Linux 2.4.22-rc1
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200308071205.06906@fbunet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo@conectiva.com.br>:
> Hello, 
> 
> Here goes the first release candidate of 2.4.22.
> 
> Please test it extensively.

Still the same USB-problem I reported for pre5 and pre10:

kernel: hub.c: new USB device 00:02.2-2, assigned address 4
kernel: scsi1 : SCSI emulation for USB Mass Storage devices
kernel:   Vendor: Maxtor 6  Model: Y120L0            Rev: 0811
kernel:   Type:   Direct-Access                   ANSI SCSI revision: 02
kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
kernel: SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
kernel:  /dev/scsi/host1/bus0/target0/lun0: p1
kernel: WARNING: USB Mass Storage data integrity not assured
kernel: USB Mass Storage device found at 4

Now I start 'dump':

kernel: usb_control/bulk_msg: timeout
kernel: usb_control/bulk_msg: timeout
kernel: usb_control/bulk_msg: timeout
kernel: usb.c: USB disconnect on device 00:02.2-2 address 4
kernel: usb-storage: host_reset() requested but not implemented
kernel: scsi: device set offline - command error recover failed: host 1 
channel 0 id 0 lun 0
kernel: 192
kernel:  I/O error: dev 08:01, sector 81655440
lots of I/O errors following

Works fine with 2.4.21.
Could someone please fix that before 2.4.22 becomes stable?

Please CC me, thanks

-- 
Fridtjof Busse
   I like to say "quark"! Quark, quark, quark, quark!
		  -- Calvin

