Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSKTVzL>; Wed, 20 Nov 2002 16:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSKTVzL>; Wed, 20 Nov 2002 16:55:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:42915 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261663AbSKTVzK>;
	Wed, 20 Nov 2002 16:55:10 -0500
Message-ID: <3DDC0661.B0292BF0@digeo.com>
Date: Wed, 20 Nov 2002 14:02:09 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Haverkamp <markh@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Call trace at mm/page-writeback.c in 2.5.47
References: <1037826852.8555.83.camel@markh1.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2002 22:02:09.0843 (UTC) FILETIME=[79172830:01C290E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Haverkamp wrote:
> 
> On Wed, 2002-11-20 at 11:07, Andrew Morton wrote:
> > Mark Haverkamp wrote:
> > >
> > > While running a memory stress workload test on a 16 processor numa
> > > system, I received a number of call traces like the following:
> >
> > What is the workload?  And in which journalling mode was ext3
> > being used?
> 
> I am using bash-shared-mapping and the ext3 journaling mode was the
> default.

OK, thanks.  The fact that we actually survive this, on ext3, on
a 16p NUMA-Q is fairly encouraging.

> ...
> 
> I get about 10 of these each time I run.  Usually after a few minutes of
> run time and all at once.  Then no more.

The warning shuts itself up after 10 messages.
 
> I tried your suggestion and still got the call traces:
> 
> buffer layer error at mm/page-writeback.c:559

I shall attempt to reproduce this, thanks.
