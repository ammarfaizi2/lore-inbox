Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUEaTSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUEaTSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 15:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbUEaTSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 15:18:33 -0400
Received: from ptb-relay01.plus.net ([212.159.14.212]:12302 "EHLO
	ptb-relay01.plus.net") by vger.kernel.org with ESMTP
	id S264731AbUEaTSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 15:18:30 -0400
Message-ID: <40BB84F6.7060003@mauve.plus.com>
Date: Mon, 31 May 2004 20:18:14 +0100
From: Ian Stirling <linux-kernel@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sd 1:0:0:0: Illegal state transition offline->cancel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to reformat my MP3 player, but it's not goint well.
Amongst the other errors was this, that I thought might be of interest.
2.6.6

May 31 20:03:21 mauve kernel: Buffer I/O error on device sdb1, logical block 7
May 31 20:03:21 mauve kernel: lost page write due to I/O error on sdb1
May 31 20:03:21 mauve kernel: Buffer I/O error on device sdb1, logical block 8
May 31 20:03:21 mauve kernel: lost page write due to I/O error on sdb1
May 31 20:03:21 mauve kernel: Buffer I/O error on device sdb1, logical block 9
May 31 20:03:21 mauve kernel: lost page write due to I/O error on sdb1
May 31 20:03:21 mauve kernel: scsi1 (0:0): rejecting I/O to offline device
May 31 20:03:21 mauve last message repeated 3 times
May 31 20:07:07 mauve kernel: sd 1:0:0:0: Illegal state transition offline->cancel
May 31 20:07:07 mauve kernel: Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1640
May 31 20:07:07 mauve kernel: Call Trace:
May 31 20:07:07 mauve kernel:  [<c027ddea>] scsi_device_set_state+0xba/0x110
May 31 20:07:07 mauve kernel:  [<c0278ed7>] scsi_device_cancel+0x27/0x11c
May 31 20:07:07 mauve kernel:  [<c02507fd>] device_for_each_child+0x5d/0x90
May 31 20:07:07 mauve kernel:  [<c0279065>] scsi_host_cancel+0x35/0xa0
May 31 20:07:07 mauve kernel:  [<c0279010>] scsi_device_cancel_cb+0x0/0x20
May 31 20:07:07 mauve kernel:  [<cc9df47f>] usb_buffer_free+0x4f/0x60 [usbcore]
May 31 20:07:07 mauve kernel:  [<c02790ec>] scsi_remove_host+0x1c/0x60
May 31 20:07:07 mauve kernel:  [<cc850d69>] storage_disconnect+0x39/0x47 [usb_storage]
May 31 20:07:07 mauve kernel:  [<cc9de106>] usb_unbind_interface+0x76/0x80 [usbcore]
May 31 20:07:07 mauve kernel:  [<c02517b6>] device_release_driver+0x66/0x70
May 31 20:07:07 mauve kernel:  [<c025192f>] bus_remove_device+0x6f/0xb0
May 31 20:07:07 mauve kernel:  [<c025072e>] device_del+0x6e/0xb0
May 31 20:07:07 mauve kernel:  [<c0250784>] device_unregister+0x14/0x30
May 31 20:07:07 mauve kernel:  [<cc9e4540>] usb_disable_device+0x70/0xb0 [usbcore]
May 31 20:07:07 mauve kernel:  [<cc9ded56>] usb_disconnect+0xc6/0x120 [usbcore]May 31 20:07:07 mauve kernel: 
[<cc9e106f>] hub_port_connect_change+0x29f/0x2b0 [usbcore]
May 31 20:07:07 mauve kernel:  [<cc9e09e1>] hub_port_status+0x41/0xb0 [usbcore]
May 31 20:07:07 mauve kernel:  [<cc9e13c3>] hub_events+0x343/0x3b0 [usbcore]
May 31 20:07:07 mauve kernel:  [<cc9e1465>] hub_thread+0x35/0xf0 [usbcore]
May 31 20:07:07 mauve kernel:  [<c0115770>] default_wake_function+0x0/0x20
May 31 20:07:07 mauve kernel:  [<cc9e1430>] hub_thread+0x0/0xf0 [usbcore]
May 31 20:07:07 mauve kernel:  [<c01032e5>] kernel_thread_helper+0x5/0x10
May 31 20:07:07 mauve kernel:
May 31 20:07:07 mauve kernel: sd 1:0:0:0: Illegal state transition offline->cancel
May 31 20:07:07 mauve kernel: Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1640
May 31 20:07:07 mauve kernel: Call Trace:
May 31 20:07:07 mauve kernel:  [<c027ddea>] scsi_device_set_state+0xba/0x110
May 31 20:07:07 mauve kernel:  [<c027fdcf>] scsi_remove_device+0x1f/0xc0
May 31 20:07:07 mauve kernel:  [<c027f1b5>] scsi_forget_host+0x55/0xa0
May 31 20:07:07 mauve kernel:  [<c02790fc>] scsi_remove_host+0x2c/0x60
May 31 20:07:07 mauve kernel:  [<cc850d69>] storage_disconnect+0x39/0x47 [usb_storage]
May 31 20:07:07 mauve kernel:  [<cc9de106>] usb_unbind_interface+0x76/0x80 [usbcore]
May 31 20:07:07 mauve kernel:  [<c02517b6>] device_release_driver+0x66/0x70
May 31 20:07:07 mauve kernel:  [<c025192f>] bus_remove_device+0x6f/0xb0
May 31 20:07:07 mauve kernel:  [<c025072e>] device_del+0x6e/0xb0
May 31 20:07:07 mauve kernel:  [<c0250784>] device_unregister+0x14/0x30
May 31 20:07:07 mauve kernel:  [<cc9e4540>] usb_disable_device+0x70/0xb0 [usbcore]
May 31 20:07:07 mauve kernel:  [<cc9ded56>] usb_disconnect+0xc6/0x120 [usbcore]
May 31 20:07:07 mauve kernel:  [<cc9e106f>] hub_port_connect_change+0x29f/0x2b0 [usbcore]
May 31 20:07:07 mauve kernel:  [<cc9e09e1>] hub_port_status+0x41/0xb0 [usbcore]
May 31 20:07:07 mauve kernel:  [<cc9e13c3>] hub_events+0x343/0x3b0 [usbcore]
May 31 20:07:07 mauve kernel:  [<cc9e1465>] hub_thread+0x35/0xf0 [usbcore]
May 31 20:07:07 mauve kernel:  [<c0115770>] default_wake_function+0x0/0x20
May 31 20:07:07 mauve kernel:  [<cc9e1430>] hub_thread+0x0/0xf0 [usbcore]
May 31 20:07:07 mauve kernel:  [<c01032e5>] kernel_thread_helper+0x5/0x10
May 31 20:07:07 mauve kernel:
May 31 20:07:17 mauve kernel: sdc: assuming drive cache: write through
May 31 20:07:20 mauve modprobe: modprobe: QM_MODULES: Function not implemented
May 31 20:07:20 mauve modprobe: modprobe: QM_MODULES: Function not implemented
May 31 20:07:20 mauve modprobe: modprobe: Can't locate module usb-storage
May 31 20:07:31 mauve kernel: scsi2: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 00 24 b3 00 00 5d 00
May 31 20:07:31 mauve kernel: Info fld=0x2500, Current sdc: sense = f0  3
May 31 20:07:31 mauve kernel: ASC=31 ASCQ= 0
May 31 20:07:31 mauve kernel: Raw sense data:0xf0 0x00 0x03 0x00 0x00 0x25 0x00 0x0a 0x00 0x00 0x00 0x00 0x31 0x00 0x00 
0x00 0x
00 0x00
May 31 20:07:31 mauve kernel: end_request: I/O error, dev sdc, sector 9472
May 31 20:07:31 mauve kernel: Buffer I/O error on device sdc1, logical block 9421
