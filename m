Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWCND2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWCND2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbWCND2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:28:42 -0500
Received: from xenotime.net ([66.160.160.81]:26786 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751809AbWCND2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:28:41 -0500
Date: Mon, 13 Mar 2006 19:30:27 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How do I get the ext3 driver to shut up?
Message-Id: <20060313193027.b0eae48e.rdunlap@xenotime.net>
In-Reply-To: <200603132218.39511.rob@landley.net>
References: <200603132218.39511.rob@landley.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006 22:18:39 -0500 Rob Landley wrote:

> I'm making a test suite for busybox mount, which does filesystem autodetection 
> the easy way (try all the ones in /etc/filesystems and /proc/filesystems 
> until one of them succeeds).  My test code is creating and mounting vfat and 
> ext2 filesystems.
> 
> Guess which device driver feels a bit chatty?
> 
> PASS: mount no proc [GNUFAIL]
> PASS: mount /proc
> PASS: mount list1
> VFS: Can't find ext3 filesystem on dev loop0.
> PASS: mount vfat image (autodetect type)
> ext3: No journal on filesystem on loop1
> PASS: mount ext2 image (autodetect type)
> PASS: mount remount ext2 image noatime
> PASS: mount remount ext2 image ro remembers noatime
> ext3: No journal on filesystem on loop0
> PASS: umount freed loop device
> PASS: mount remount nonexistent directory
> PASS: mount -a no fstab

Hrm, yes, 2 of those lines do come from ext3.
Where do the rest of them come from?


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
