Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTJBSww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTJBSww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:52:52 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:54031
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S263461AbTJBSwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:52:50 -0400
Date: Thu, 2 Oct 2003 11:52:48 -0700
From: Brad Boyer <flar@allandria.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-hfsplus-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
Message-ID: <20031002185248.GA24046@pants.nu>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv> <20031002180645.GG7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031002180645.GG7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 07:06:45PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> What the devil are you doing with get_gendisk() in there?  Neither 2.4
> nor 2.6 should be messing with it.

Since this topic has come up, I'd like to ask about something that
apparently only affects HFS/HFS+. For some reason, Apple decided
that a Mac style CD-ROM should be a partitioned device. However,
the Linux kernel is quite insistent that a CD-ROM is not able to
be partitioned. Because of this, there's a hack to manually read
a partition map and find the correct part of the block device.

Would it be possible to have a way to use the gendisk and partitioning
code that is already in the kernel for regular disks to read these
CDs? It also might be useful for the loopback device.

Just as an example of worst case, the main A/UX install CD had
not only an HFS partition, but multiple UFS partitions. If you
really want a view of the extent of Apple hackery, take a look
at arch/m68k/mac and groan.  :)

	Brad Boyer
	flar@allandria.com

