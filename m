Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSJDTJk>; Fri, 4 Oct 2002 15:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261781AbSJDTJk>; Fri, 4 Oct 2002 15:09:40 -0400
Received: from packet.digeo.com ([12.110.80.53]:16093 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261733AbSJDTJj>;
	Fri, 4 Oct 2002 15:09:39 -0400
Message-ID: <3D9DE8BA.D30EA433@digeo.com>
Date: Fri, 04 Oct 2002 12:15:06 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] patch-slab-split-03-tail
References: <3D9DE69C.C6E88C9F@digeo.com> <1121907497.1033733278@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2002 19:15:06.0802 (UTC) FILETIME=[597A3920:01C26BDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> > Run that by me again?  So we're saying "if we just freed an
> > object from this page then make this page be the *last* page
> > which is eligible for new allocations"?  Under the assumption
> > that other objects in that same page are about to be freed
> > up as well?
> >
> > Makes sense.  It would be nice to get this confirmed in
> > targetted testing ;)
> 
> Just doing my normal boring kernel compile suggest Manfred's
> last big rollup performs exactly the same as without it. Not
> sure if that's any help or not ....
> 

Well.  This patch is supposed to decrease internal fragmentation.
We need to prove that theory.  An appropriate test would be:

- boot with `mem=48m'
- untar kernel
- build kernel
- capture /proc/slabinfo

- apply patch

- repeat

- compare and explain.

I know what your reboot times are like ;)  I'll do it.
