Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbTDLC1M (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 22:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTDLC1M (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 22:27:12 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:44697 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263104AbTDLC1L (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 22:27:11 -0400
Date: Sat, 12 Apr 2003 12:38:48 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
Subject: Re: 2.5.66: slow to friggin slow journal recover
Message-ID: <20030412023848.GB650@zip.com.au>
References: <20030401100237.GA459@zip.com.au> <20030401022844.2dee1fe8.akpm@digeo.com> <20030412021638.GA650@zip.com.au> <20030411192413.279f0574.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411192413.279f0574.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 07:24:13PM -0700, Andrew Morton wrote:
> CaT <cat@zip.com.au> wrote:
> >  [<c0138618>] handle_mm_fault+0x68/0xfc
> >  [<c0116960>] do_page_fault+0x0/0x3fe
> >  [<c01494ee>] blkdev_file_write+0x26/0x30
> >  [<c0142f4e>] vfs_read+0xa2/0xd4
> >  [<c014312a>] sys_read+0x2a/0x40
> >  [<c0108cf3>] syscall_call+0x7/0xb
> 
> OK, you may be thrashing the VM.  fsck can use a lot of memory.

*nod* Woiuld this also cause the kernel to hang? Last time this happened
it was on a small 256MB partition that holds 13 files (it's /var/mail)

> How large is the filesystem?

Not sure which one it was this time but the two possibilities are 1.2GB
and 197MB. It does this on either partition.

> How many files are on the filesystem?

197MB: 2728 files
1.2GB: 53707 files

> How much physical memory does the machine have?

256MB

> Run ALT-sysrq-M during the fsck to get some stats.

Ok. I'll try and get it to work for me again (and not interrupt the fsck
:/).

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
