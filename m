Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbWJKRIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWJKRIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWJKRIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:08:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:63927 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161087AbWJKRIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:08:51 -0400
Subject: Re: 2.6.19-rc1-mm1 (ext4 problem ?)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Theodore Tso <tytso@mit.edu>, lkml <linux-kernel@vger.kernel.org>,
       shaggy@us.ibm.com, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <20061011095639.ad8169f7.akpm@osdl.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <452C616D.7040701@us.ibm.com> <20061010210133.dda19d4c.akpm@osdl.org>
	 <1160578934.1447.1.camel@dyn9047017100.beaverton.ibm.com>
	 <20061011095639.ad8169f7.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 10:08:30 -0700
Message-Id: <1160586510.1447.7.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 09:56 -0700, Andrew Morton wrote:
> On Wed, 11 Oct 2006 08:02:14 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
> > On Tue, 2006-10-10 at 21:01 -0700, Andrew Morton wrote: 
> > > 
> > > > Andrew Morton wrote:
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> > > > >
> > > > >
> > > > > - Added the ext4 filesystem.  Quick usage instructions:
> > > > >
> > > > >   - Grab updated e2fsprogs from
> > > > >     ftp://ftp.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs-interim/
> > > > >   
> > 
> > ext4 did not survive my simple stress tests. 
> > 
> > I ran 4 copies of fsx on ext4dev filesystem (without extents) +
> > 4 copies of fsx on ext4dev (with extents). 
> > 
> > Machine hung after running for few hours. There are 4 fsx sigsegv
> > messages on the console and the last message on the console is
> > 
> > do_IRQ: 0.62 No irq handler for vector
> > 
> 
> Quite a few people are hitting that - it's related to Eric's recent
> IRQ/APIC-routing changes.
> 
> I don't know why that would cause fsx to get a sigsegv though.

I don't think they are related. Hopefully once we figure out IRQ
problem, we can try to track down fsx problems.

Thanks,
Badari

