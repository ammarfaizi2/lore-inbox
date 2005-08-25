Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVHYSXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVHYSXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVHYSXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:23:39 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:41169 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S932321AbVHYSXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:23:38 -0400
Date: Thu, 25 Aug 2005 14:23:32 -0400 (EDT)
Message-Id: <200508251823.j7PINW1g001660@ms-smtp-01.rdc-nyc.rr.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-URL: mailto:linux-kernel@vger.kernel.org
X-Mailer: Lynx, Version 2.8.6dev.13c
From: robotti@godmail.com
Subject: Initramfs and TMPFS!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   >On Thu, Aug 25, 2005 at 11:38:49AM -0400, robotti@xxxxxxxxxxx wrote:
   >What if you have a root.cpio.gz that requires 200MB to hold, but you
   >only have 300MB of memory?
   >
   >50% of total memory wouldn't hold it, but 90% etc. would
   >(tmpfs_size=90%).

   >>tmpfs will not help you here. Yes, it can be swapped, but just like
   >>with ramfs you first need to *unpack* the cpio archive before you can
   >>even start the "swapon /dev/hda2" command on it.

I was making a case for a tmpfs_size option if tmpfs is used for a initramfs,
because tmpfs has a default 50% memory limit.

   >>Same with initrd, btw. If the compressed initrd image, plus the
   >>uncompressed image, plus the kernel size are larger than the memory
   >>size, the system will not boot.

Right.

   
