Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSK3WI1>; Sat, 30 Nov 2002 17:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbSK3WI0>; Sat, 30 Nov 2002 17:08:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:18672 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261205AbSK3WIY>;
	Sat, 30 Nov 2002 17:08:24 -0500
Message-ID: <3DE9388F.CD7E33FB@digeo.com>
Date: Sat, 30 Nov 2002 14:15:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.20-jam0
References: <20021129233807.GA1610@werewolf.able.es> <3DE80AB6.611F3A8C@digeo.com> <20021130144541.GA2517@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2002 22:15:44.0171 (UTC) FILETIME=[06993FB0:01C298BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> On 2002.11.30 Andrew Morton wrote:
> >"J.A. Magallon" wrote:
> >>
> >> - Orlov inode allocator for 2.4
> >
> >The Orlov allocator in 2.5 has caused a tremendous performance regression
> >in dbench-on-ext3/ordered-on-scsi.
> >
> >I don't know why yet - I doubt if it's due to the allocator itself - more
> >likely an IO scheduling bug in ext3, or a bug in the 2.5 elevator.
> >
> >There is no such regression on IDE - presumably write caching is covering
> >up the problem.
> >
> 
> Is there any way I can test that ? I have all scsi drives and can
> for example remount with 'orlov' or 'oldalloc'...

It is specific to SMP, and for some reason doesn't manifest with
IDE hardware.

See
http://sourceforge.net/mailarchive/forum.php?thread_id=1365460&forum_id=6379
for the analysis.
