Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSJ3J3T>; Wed, 30 Oct 2002 04:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSJ3J3T>; Wed, 30 Oct 2002 04:29:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:63418 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264643AbSJ3J3S>;
	Wed, 30 Oct 2002 04:29:18 -0500
Message-ID: <3DBFA7E3.345690B2@digeo.com>
Date: Wed, 30 Oct 2002 01:35:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Hans Reiser <reiser@namesys.com>, torvalds@transmeta.com,
       Nikita Danilov <Nikita@namesys.com>, landley@trommello.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 merge candidate list, final version.  (End of "crunch 
 time"series.)
References: <200210280534.16821.landley@trommello.org> <15805.27643.403378.829985@laputa.namesys.com> <3DBF9600.4060208@namesys.com> <3DBF9BA5.6000100@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2002 09:35:32.0194 (UTC) FILETIME=[B0EFA420:01C27FF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Hans Reiser wrote:
> 
> > We are going to submit a patch appropriate for inclusion as an
> > experimental FS on Halloween.   I hope you will forgive our pushing
> > the limit timewise, it is not by choice, but the algorithms we used to
> > more than double reiserfs V3 performance were, quite frankly, hard to
> > code.
> 
> Does your merge change the core code at all?  Does it add new syscalls?
> 

Their changes are tiny, and sensible.  See
http://www.namesys.com/snapshots/2002.10.29/

But I'd like to ask about the status of reiser3 support.

Chris had patches *ages* ago to convert it to use direct-to-BIO for
reads, and writes should be done as well.  reiserfs3 is still using
buffer-head-based IO for bulk reads and writes.  That's a 25-30% hit
in CPU cost, and all the old ZONE_NORMAL-full-of-buffer_heads
problems.

Any plans to get that work finished off?
