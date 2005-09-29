Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVI2QAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVI2QAQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVI2QAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:00:15 -0400
Received: from 122.0.203.62.cust.bluewin.ch ([62.203.0.122]:64091 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S932190AbVI2QAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:00:14 -0400
Date: Thu, 29 Sep 2005 18:00:07 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Temporary workaround for stuck CD burner
Message-ID: <20050929160006.GA19550@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to turn off the DVD burner by suspending the laptop to disk
and reviving.

Now the command
cdrecord -tao dev=ATAPI:0,0,0 speed=8 /home/clock/cdrom.iso
is behaving like in those good olden days before Linux kernel seizure.

More information: dmesg reveals that during the seizure, no dmesg
messages were generated (no SCSI errors/timeouts etc.).

When mounting the first badly burned CD, SCSI errors were generated.
Last 3 of them:

hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete
Error }
hdc: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 8
printk: 2 messages suppressed.
Buffer I/O error on device hdc, logical block 1
hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete
Error }
hdc: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 16
hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete
Error }
hdc: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 0

CL<
