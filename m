Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUFBMK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUFBMK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUFBMK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:10:58 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:8334 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262170AbUFBMKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:10:39 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fix dependeces for CONFIG_USB_STORAGE
Date: Wed, 2 Jun 2004 14:11:38 +0200
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Linux-kernel <linux-kernel@vger.kernel.org>
References: <200406021116.35529.ornati@fastwebnet.it> <200406021352.14561.ornati@fastwebnet.it> <20040602115204.GA731@infradead.org>
In-Reply-To: <20040602115204.GA731@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406021411.38514.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 13:52, Christoph Hellwig wrote:
> On Wed, Jun 02, 2004 at 01:52:14PM +0200, Paolo Ornati wrote:
> > So if you want to use USB Mass Storage devices (that use SCSI
> > emulation) you need also SCSI disk support (I have realized it when
> > I've tried to mount one those USB devices, without success).
>
> There's also external usb cdrom enclosures.  In which case you only need
> sr.

ok... you are right...

Consequently this help could be a bit more explicit:

config USB_STORAGE
        tristate "USB Mass Storage support"
        depends on USB
        select SCSI
        ---help---
          Say Y here if you want to connect USB mass storage devices to your
          computer's USB port. This is the driver you need for USB floppy 
drives,
          USB hard disks, USB tape drives and USB CD-ROMs, along with
          similar devices. This driver may also be used for some cameras and
          card readers.

For example we can add something like this:
NOTE that these devices use SCSI emulation, so remember to enable the needed 
support in "SCSI Devices" section (for example: enable "SCSI Disk Support" 
if you are going to use USB hard drives).

;-)

-- 
	Paolo Ornati
	Linux v2.6.6

