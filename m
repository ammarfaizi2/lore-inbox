Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbTC0PNk>; Thu, 27 Mar 2003 10:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbTC0PNk>; Thu, 27 Mar 2003 10:13:40 -0500
Received: from franka.aracnet.com ([216.99.193.44]:29592 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261804AbTC0PNj>; Thu, 27 Mar 2003 10:13:39 -0500
Date: Thu, 27 Mar 2003 07:24:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 510] New: USB storage doesn't work on my Sony Vaio C1VE
Message-ID: <11420000.1048778690@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=510

           Summary: USB storage doesn't work on my Sony Vaio C1VE
    Kernel Version: 2.5.66-bk2
            Status: NEW
          Severity: blocking
             Owner: greg@kroah.com
         Submitter: stelian@popies.net


Distribution: RedHat 8.0
Hardware Environment: Sony Vaio C1VE (same as C1VM/C1VN in other countries),
external USB floppy drive, internal memory stick USB reader
Software Environment: mount...
Problem Description: Neither the floppy drive nor the memory stick reader
work, even if they seem to trigger different bugs

First of all, both the floppy drive and the memory stick reader work
perfectly under a 2.4 kernel.

When used with 2.5.66, the memory stick reader is seen as a USB device, but
not always detected as a SCSI disk. The floppy drive is immediately
recognized as a USB device and a SCSI disk.

However, trying to read/write data (with dd, mount etc) doesn't work,
errors are shown in the kernel logs and the operations are _very_ slow
(the mount process hangs for 5 minutes before giving up, it's wchan being
scsi_wait_req).

I'm attaching several kernel logs:
* memstick.ok, floppy.ok: kernel logs of successful operations on a
2.4.21-pre6 kernel
* memstick.bad, floppy.bad: kernel logs of failure on 2.5.66-bk2
* usbstorage.oops: an oops I got while playing with 2.5.66-bk2 and tried to
remove usb-storage to see if it helps to reinsert it. I'm attaching it
here, and not in a separate bug report because it may be related to my
failures.

I can give more information if it is needed (enable debugging in USB and/or
SCSI somewhere, test patches etc.), just say it.

Stelian.

