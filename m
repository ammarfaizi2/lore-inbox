Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWIVRaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWIVRaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWIVRaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:30:24 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S964784AbWIVRaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:30:23 -0400
Received: from xenotime.net ([66.160.160.81]:60056 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932552AbWIVOr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:47:56 -0400
Date: Fri, 22 Sep 2006 07:48:58 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060922074858.cee79365.rdunlap@xenotime.net>
In-Reply-To: <1158919801.24527.668.camel@pmac.infradead.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<1158917046.24527.662.camel@pmac.infradead.org>
	<1158919801.24527.668.camel@pmac.infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.8 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
X-Face: &4L4\Oj/><0~x8W<MJeAB.(xC/cwW7Ay$UNDMI|/>]44\M(/wa:+,kH&IYtRqs\tQ8="B5=
 qPUwTvq4QPk_KQ^$5ya89f&[m.$<>cp-F(**n,^uIaN{YfG
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 11:10:01 +0100 David Woodhouse wrote:

> On Fri, 2006-09-22 at 10:24 +0100, David Woodhouse wrote:
> > On Wed, 2006-09-20 at 13:54 -0700, Andrew Morton wrote:
> > > 
> > > mtd-maps-ixp4xx-partition-parsing.patch
> > > fix-the-unlock-addr-lookup-bug-in-mtd-jedec-probe.patch
> > > mtd-printk-format-warning.patch
> > > fs-jffs2-jffs2_fs_ih-removal-of-old-code.patch
> > > drivers-mtd-nand-au1550ndc-removal-of-old-code.patch
> > > 
> > >  MTD queue -> dwmw2
> > 
> > Merged, with the exception of the unlock addr one which I'm still not
> > sure about -- about to investigate harder.
> 
> I just reverted Randy's printk format 'fix', since rq->flags _is_ an
> unsigned long, so changing from %ld to %d actually _introduces_ a
> warning.
> 
> Randy, that's the second time I recall recently that I've ended up
> reverting a printk format fix from you -- what are you doing? How did
> you manage to get the warning you reported:
> 
> drivers/mtd/mtd_blkdevs.c:72: warning: long int format, different type arg (arg 2)

That was originally posted as a patch to -mm, where that field
has been changed to (unsigned?) int.  Maybe it should be part
of Jens's block patches, since that is what changes the field
size.

---
~~Randy
