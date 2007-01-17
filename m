Return-Path: <linux-kernel-owner+w=401wt.eu-S932342AbXAQLpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbXAQLpg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 06:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbXAQLpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 06:45:36 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:37503 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S932342AbXAQLpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 06:45:36 -0500
Date: Wed, 17 Jan 2007 12:45:33 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Turbo Fredriksson <turbo@bayour.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird harddisk behaviour
Message-ID: <20070117114533.GA25077@harddisk-recovery.com>
References: <87bqkzp0et.fsf@pumba.bayour.com> <20070116141959.GC476@deepthought> <87y7o2hsmm.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y7o2hsmm.fsf@pumba.bayour.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 11:09:21AM +0100, Turbo Fredriksson wrote:
> Quoting Ken Moffat <zarniwhoop@ntlworld.com>:
> >  Certainly, fdisk from util-linux doesn't know about mac disks, and
> > I thought the same was true for cfdisk and sfdisk.  Many years ago
> > there was mac-fdisk, I think also known as pdisk, but nowadays the
> > common tool for partitioning mac disks is probably parted.
> 
> Yes. See now that 'fdisk' is a softlink to 'mac-fdisk'...
> 
> > Please try parted.
> 
> Same thing ('mkpartfs primary ext2 0 400000'):
> 
> Jan 17 11:03:41 localhost kernel: [254985.117447] EXT2-fs: sdb1: couldn't mount RDWR because of unsupported optional features (10000).

I don't know if any of those tools tell the kernel that the partition
table changedand that it has to reread them. To be sure the kernel
knows, run "blockdev --rereadpt /dev/sdb".


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
