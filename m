Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbTIEAKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTIEAKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:10:16 -0400
Received: from 176.Red-217-125-42.pooles.rima-tde.net ([217.125.42.176]:8943
	"EHLO falafell") by vger.kernel.org with ESMTP id S261274AbTIEAKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:10:09 -0400
Date: Fri, 5 Sep 2003 02:09:49 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4, 2.6.0-test4-mm4  usb problems fixed in mm5
Message-ID: <20030905000949.GA1258@barcelonawireless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Pedro Larroy <piotr@barcelonawireless.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've been experiencing problems with an external usb ata disk with kernels 2.6.0-test4 
that seems to be fixed with -mm5 patch

So there is no problem with 2.4.21 nor with 2.6.0-test4-mm5

Regards.
--
piotr.

Here is the usb-storage debug in case it helps:

usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 0d a7 0f 9f 00 04 00 00
usb-storage: Bulk command S 0x43425355 T 0x1dd8 Trg 0 LUN 0 L 524288 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 127 entries
usb-storage: Status code 0; transferred 524288/524288
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
usb-storage: command_abort called
usb-storage: usb_stor_stop_transport called
usb-storage: -- cancelling URB
usb-storage: Status code -104; transferred 0/13
usb-storage: -- transfer cancelled
usb-storage: Bulk status result = 4
usb-storage: -- command was aborted
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0

.....


usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
usb-storage: command_abort called
usb-storage: usb_stor_stop_transport called
usb-storage: -- cancelling URB
usb-storage: Status code -104; transferred 0/13
usb-storage: -- transfer cancelled
usb-storage: Bulk status result = 4
usb-storage: -- command was aborted
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
[ACPI Debug] String: ==Battery1 _BST==
[ACPI Debug] String: ==Battery1 _BST==
usb-storage: Soft reset: clearing bulk-in endpoint halt

