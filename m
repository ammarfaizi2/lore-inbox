Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbTJVCQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 22:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTJVCQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 22:16:44 -0400
Received: from 116.Red-81-38-199.pooles.rima-tde.net ([81.38.199.116]:53843
	"EHLO falafell.ghetto") by vger.kernel.org with ESMTP
	id S263329AbTJVCQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 22:16:43 -0400
Date: Wed, 22 Oct 2003 04:10:28 +0200
From: Pedro Larroy <piotr@member.fsf.org>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: aborts in usb-storage in branch 2.6
Message-ID: <20031022021028.GA4454@81.38.200.176>
Reply-To: piotr@member.fsf.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


I experience aborts with external usb hd, that also pause all disk
operations for some seconds.

It doesn't happen with 2.4.21 kernel.

Please tell me if I can do anything useful to debug the problem. I can use
kgdb or other techniques.

It's getting very annoying since the disk stays for more than 10 seconds
without responding.


usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=88
len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Attempting to get CSW (2nd try)...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code -32; transferred 0/13
usb-storage: clearing endpoint halt for pipe 0xc0040280
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=88
len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Bulk status result = 2
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00
len=0
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
b-storage: scsi command aborted
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x1162 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31



Regards.

-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
