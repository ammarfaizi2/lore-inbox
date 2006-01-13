Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161629AbWAMBVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161629AbWAMBVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 20:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161630AbWAMBVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 20:21:04 -0500
Received: from mailhub1.uq.edu.au ([130.102.148.128]:62986 "EHLO
	mailhub1.uq.edu.au") by vger.kernel.org with ESMTP id S1161629AbWAMBVD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 20:21:03 -0500
Date: Fri, 13 Jan 2006 11:20:48 +1000
From: Adam Nielsen <adam.nielsen@uq.edu.au>
To: linux-kernel@vger.kernel.org
Subject: "umount: device is busy" when device is not in use?
Message-ID: <20060113112048.2cf1f3ae@orps-it1.research.uq.edu.au>
X-Mailer: Sylpheed-Claws 1.9.99 (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Is it possible to ask the kernel what processes are using a particular
filesystem?

The reason being I have a stubborn NFS mount that refuses to unmount
saying it's in use, but I can't find what's using it:

$ umount /mnt/data
umount: /mnt/data: device is busy
umount: /mnt/data: device is busy

$ umount -f /mnt/data
umount2: Device or resource busy
umount: /mnt/data: device is busy
umount2: Device or resource busy
umount: /mnt/data: device is busy

$ lsof | grep data
<nothing>

So the kernel obviously thinks the filesystem is in use, but I'm
not sure how to find out what's using it.  No processes have their
current working directory on this filesystem, and I'm sure there
aren't any open files on it.

Even forcefully unmounting the filesystem (-f) doesn't work, although
I've never gotten that to work before.  Is it even possible to force an
unmount of a filesystem that's in use?

This is under kernel 2.6.14.

Thanks,
Adam.
