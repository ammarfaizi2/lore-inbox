Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263175AbTCSUt4>; Wed, 19 Mar 2003 15:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263178AbTCSUtz>; Wed, 19 Mar 2003 15:49:55 -0500
Received: from spc1.esa.lanl.gov ([128.165.67.191]:17792 "EHLO
	spc1.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S263175AbTCSUto>; Wed, 19 Mar 2003 15:49:44 -0500
Subject: Re: 2.5.65-mm2
From: "Steven P. Cole" <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030319121055.685b9b8c.akpm@digeo.com>
References: <20030319012115.466970fd.akpm@digeo.com>
	 <1048103489.1962.87.camel@spc9.esa.lanl.gov>
	 <20030319121055.685b9b8c.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048107434.1743.12.camel@spc1.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-1mdk 
Date: 19 Mar 2003 13:57:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 13:10, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > On Wed, 2003-03-19 at 02:21, Andrew Morton wrote:
> > > 
> > > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.65/2.5.65-mm2/
> > > 
> > 
> > I am seeing a significant degradation of interactivity under load with
> > recent -mm kernels.  The load is dbench on a reiserfs file system with
> > increasing numbers of clients.  The test machine is single PIII, IDE,
> > 256MB memory, all kernels PREEMPT.
> 
> (This email brought to you while running dbench 128 on ext3)
> 
> There's a pretty big reiserfs patch in -mm.  Are you able to whip up
> an ext2 partition and see if that displays the same problem?
> 

I repeated the test on an ext3 partition, and the response with 28
dbench clients running is definitely better, although I'm starting to
get some stalls of a couple seconds while typing this in Evolution on
the machine under test.  Now it's becoming intolerable, so I aborted the
dbench run so I could finish this email.

This was with 2.5.65-mm2 and elevator=as.  I'll repeat soon with
elevator=deadline.  I didn't try typing in Evolution with 2.5.65-bk
under high loads, so I'll also give that a try.

Summary: using ext3, the simple window shake and scrollbar wiggle tests
were much improved, but really using Evolution left much to be desired.

Steven
