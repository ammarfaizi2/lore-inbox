Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUKPJlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUKPJlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUKPJk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:40:28 -0500
Received: from CPE-203-51-35-114.nsw.bigpond.net.au ([203.51.35.114]:58355
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261392AbUKPJkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:40:10 -0500
Message-ID: <4199CAF8.1000501@eyal.emu.id.au>
Date: Tue, 16 Nov 2004 20:40:08 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.10 usb-storage too verbose
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I mount/read/unmount a USB disk I end up with tons of messages like
below. Should it be this verbose on a stable kernel (I would understand
debugging)?

usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 0b 0d a8 00 00 80 00
usb-storage: Bulk Command S 0x43425355 T 0x32c L 65536 F 128 Trg 0 LUN 0 CL 12
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 65536 bytes, 1 entries
usb-storage: Status code 0; transferred 65536/65536
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x32c R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 0b 0e 28 00 00 80 00
usb-storage: Bulk Command S 0x43425355 T 0x32d L 65536 F 128 Trg 0 LUN 0 CL 12
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 65536 bytes, 2 entries

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
