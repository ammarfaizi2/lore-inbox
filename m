Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWCIUtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWCIUtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 15:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCIUtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 15:49:14 -0500
Received: from mail.dolby.com ([204.156.147.24]:29446 "EHLO dolby.com")
	by vger.kernel.org with ESMTP id S1751439AbWCIUtO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 15:49:14 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Subject: FW: UFS sunx86 write not functional, possible bug.
Date: Thu, 9 Mar 2006 12:48:39 -0800
Message-ID: <2692A548B75777458914AC89297DD7DA0EBCC1DC@bronze.dolby.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: UFS sunx86 write not functional, possible bug.
Thread-Index: AcZDuVgkox3/7a1TSbCGcLEGcIYmWwAAJbdw
From: "Gilbert, John" <JGG@dolby.com>
To: <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux kernel folks,

Minor bug #1, Daniel Pirkl's email in Documentation/filesystems/ufs.txt
no longer works.
Major bug #2, mount reports UFS (rw,ufstype=sunx86), but filesystem is
still read-only. Details below.

Thanks.
John G.
jgg ?at# dolby ?dot# com

-----Original Message-----
From: Gilbert, John 
Sent: Thursday, March 09, 2006 12:38 PM
To: 'daniel.pirkl@email.cz'
Subject: UFS sunx86 write not functional, possible bug.

Hello Daniel Pirkl,

I have a Solaris x86 partition mounted under Linux 2.6.15.6, mount shows
it as type ufs (rw,ufstype=sunx86), but any attempt to write to the
partition results in a "Read-only file system" error.

Do you have any ideas on what I could try to get this working?

Both CONFIG_UFS_FS and CONFIG_UFS_FS_WRITE = y in the kernel config.
"dmesg" shows "ufs_read_super: fs needs fsck", but any attempt to use
fsck on these partitions results in
"fsck: fsck.ufs: not found, fsck: Error 2 while executing fsck.ufs for
/dev/sda11". A quick Google search suggests that fsck.ufs doesn't exist
yet for Linux.
I've booted back into Solaris 10, unmounted the partition, fscked it (it
was clean), rebooted into Linux and still the same problem.
I've looked though the kernel ufs code but there wasn't anything obvious
(to me).
The only other thing I can think of is that Solaris 10 is running in
64-bit mode, and I'm currently working on a 32 bit Linux system.

Thanks in advance for your help.
John G.

-----------------------------------------
This message (including any attachments) may contain confidential
information intended for a specific individual and purpose.  If you
are not the intended recipient, delete this message.  If you are
not the intended recipient, disclosing, copying, distributing, or
taking any action based on this message is strictly prohibited.

