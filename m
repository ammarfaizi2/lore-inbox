Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbTB1ARy>; Thu, 27 Feb 2003 19:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267292AbTB1ARy>; Thu, 27 Feb 2003 19:17:54 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:9373 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S267308AbTB1ARw>;
	Thu, 27 Feb 2003 19:17:52 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: Rising io_load results Re: 2.5.63-mm1
Date: Fri, 28 Feb 2003 11:28:06 +1100
User-Agent: KMail/1.5
Cc: dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030227025900.1205425a.akpm@digeo.com> <200302281056.45501.kernel@kolivas.org> <20030227160656.40ebeb93.akpm@digeo.com>
In-Reply-To: <20030227160656.40ebeb93.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302281128.06840.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003 11:06 am, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > On Fri, 28 Feb 2003 09:01 am, Dave McCracken wrote:
> > > --On Thursday, February 27, 2003 13:44:03 -0800 Andrew Morton
> > >
> > > <akpm@digeo.com> wrote:
> > > >> ...
> > > >> Mapped:       4294923652 kB
> > > >
> > > > Well that's gotta hurt.  This metric is used in making writeback
> > > > decisions.  Probably the objrmap patch.
> > >
> > > Oops.  You're right.  Here's a patch to fix it.
> >
> > Thanks.
> >
> > This looks better after a run:
> >
> > MemTotal:       256156 kB
> > ...
> > Mapped:        4546752 kB
>
> No, it is still wrong.  Mapped cannot exceed MemTotal.

Hmm a few more runs and io_load starts rising again and this is the meminfo in 
the middle of a run:

MemTotal:       256156 kB
MemFree:         26564 kB
Buffers:         11300 kB
Cached:         198048 kB
SwapCached:          0 kB
Active:           7164 kB
Inactive:       204736 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256156 kB
LowFree:         26564 kB
SwapTotal:     4194272 kB
SwapFree:      4194272 kB
Dirty:            5780 kB
Writeback:           0 kB
Mapped:        6000680 kB
Slab:            13056 kB
Committed_AS:     7040 kB
PageTables:        200 kB
ReverseMaps:       664

Con

