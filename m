Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbUKWAT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUKWAT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbUKWAQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 19:16:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:41186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262484AbUKWANO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 19:13:14 -0500
Date: Mon, 22 Nov 2004 16:17:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phil Dier <phil@dier.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041122161725.21adb932.akpm@osdl.org>
In-Reply-To: <20041122130622.27edf3e6.phil@dier.us>
References: <20041122130622.27edf3e6.phil@dier.us>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Dier <phil@dier.us> wrote:
>
> I'm setting up a storage array with Linux, software RAID, LVM, and XFS,
> but I keep getting oopses during heavy I/O. I've been able to reproduce
> this with 2.6.6, 2.6.8.1, 2.6.9, and 2.6.10-rc2-bk4. I have dual xeon
> 2.8s with 4gb of ram. I'm using adaptec and a fusion mpt scsi devices
> (more details in the following link). Connected are 2 ultra160 scsi
> jbods w/ 2 disks apiece. I'm using raid 10 (or should it be 01?) mirrored 
> stripes.
> 
> Due to its size, I've posted my debug info at this location (I've included
> output from all of the above kernels):
> 
> <http://www.icglink.com/cluster-debug-info.html> (~235kb)

yow.  The dread combination of XFS, LVM, software RAID and bloaty scsi
drivers.  Looks like a stack overrun.

Can you rebuild the kernel with CONFIG_4KSTACKS=n?

