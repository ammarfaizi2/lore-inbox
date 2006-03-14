Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWCNRZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWCNRZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWCNRZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:25:07 -0500
Received: from xenotime.net ([66.160.160.81]:11929 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750853AbWCNRZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:25:06 -0500
Date: Tue, 14 Mar 2006 09:26:54 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How do I get the ext3 driver to shut up?
Message-Id: <20060314092654.6480af88.rdunlap@xenotime.net>
In-Reply-To: <200603141020.27963.rob@landley.net>
References: <200603132218.39511.rob@landley.net>
	<20060313193027.b0eae48e.rdunlap@xenotime.net>
	<200603141020.27963.rob@landley.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006 10:20:27 -0500 Rob Landley wrote:

> On Monday 13 March 2006 10:30 pm, Randy.Dunlap wrote:
> > On Mon, 13 Mar 2006 22:18:39 -0500 Rob Landley wrote:
> > > I'm making a test suite for busybox mount, which does filesystem
> > > autodetection the easy way (try all the ones in /etc/filesystems and
> > > /proc/filesystems until one of them succeeds).  My test code is creating
> > > and mounting vfat and ext2 filesystems.
> > >
> > > Guess which device driver feels a bit chatty?
> > >
> > > PASS: mount no proc [GNUFAIL]
> > > PASS: mount /proc
> > > PASS: mount list1
> > > VFS: Can't find ext3 filesystem on dev loop0.
> > > PASS: mount vfat image (autodetect type)
> > > ext3: No journal on filesystem on loop1
> > > PASS: mount ext2 image (autodetect type)
> > > PASS: mount remount ext2 image noatime
> > > PASS: mount remount ext2 image ro remembers noatime
> > > ext3: No journal on filesystem on loop0
> > > PASS: umount freed loop device
> > > PASS: mount remount nonexistent directory
> > > PASS: mount -a no fstab
> >
> > Hrm, yes, 2 of those lines do come from ext3.
> 
> Three, actually.

Agreed (the VFS: line also).

---
~Randy
