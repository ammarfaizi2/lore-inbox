Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269661AbTHGTWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270065AbTHGTWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:22:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:43456 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269661AbTHGTWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:22:15 -0400
Date: Thu, 7 Aug 2003 12:22:14 -0700
From: Greg KH <greg@kroah.com>
To: Fridtjof Busse <fbusse@gmx.de>, usb-storage@one-eyed-alien.net
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Linux 2.4.22-rc1
Message-ID: <20030807192214.GB12055@kroah.com>
References: <200308071205.06906@fbunet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308071205.06906@fbunet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 12:05:06PM +0200, Fridtjof Busse wrote:
> * Marcelo Tosatti <marcelo@conectiva.com.br>:
> > Hello, 
> > 
> > Here goes the first release candidate of 2.4.22.
> > 
> > Please test it extensively.
> 
> Still the same USB-problem I reported for pre5 and pre10:

The usb-storage people should look into this (I've copied them on this.)

Hint, hint...

thanks,

greg k-h



> 
> kernel: hub.c: new USB device 00:02.2-2, assigned address 4
> kernel: scsi1 : SCSI emulation for USB Mass Storage devices
> kernel:   Vendor: Maxtor 6  Model: Y120L0            Rev: 0811
> kernel:   Type:   Direct-Access                   ANSI SCSI revision: 02
> kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
> kernel: SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
> kernel:  /dev/scsi/host1/bus0/target0/lun0: p1
> kernel: WARNING: USB Mass Storage data integrity not assured
> kernel: USB Mass Storage device found at 4
> 
> Now I start 'dump':
> 
> kernel: usb_control/bulk_msg: timeout
> kernel: usb_control/bulk_msg: timeout
> kernel: usb_control/bulk_msg: timeout
> kernel: usb.c: USB disconnect on device 00:02.2-2 address 4
> kernel: usb-storage: host_reset() requested but not implemented
> kernel: scsi: device set offline - command error recover failed: host 1 
> channel 0 id 0 lun 0
> kernel: 192
> kernel:  I/O error: dev 08:01, sector 81655440
> lots of I/O errors following
> 
> Works fine with 2.4.21.
> Could someone please fix that before 2.4.22 becomes stable?
> 
> Please CC me, thanks
> 
> -- 
> Fridtjof Busse
>    I like to say "quark"! Quark, quark, quark, quark!
> 		  -- Calvin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
