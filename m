Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262236AbSIZH5K>; Thu, 26 Sep 2002 03:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbSIZH5K>; Thu, 26 Sep 2002 03:57:10 -0400
Received: from packet.digeo.com ([12.110.80.53]:57307 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262236AbSIZH5J>;
	Thu, 26 Sep 2002 03:57:09 -0400
Message-ID: <3D92BF0C.DBDDFA38@digeo.com>
Date: Thu, 26 Sep 2002 01:02:20 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.19pre10aa4 OOPS in ext3 (get_hash_table,  
 unmap_underlying_metadata)
References: <3D92A1D0.5000203@metaparadigm.com> <3D92B6F3.1428A76A@digeo.com> <3D92BDC8.8080603@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 08:02:20.0739 (UTC) FILETIME=[0A1FD130:01C26533]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:
> 
> On 09/26/02 15:27, Andrew Morton wrote:
> > Michael Clark wrote:
> >
> >>Hiya,
> >>
> >>Been having frequent (every 4-8 days) oopses with 2.4.19pre10aa4 on
> >>a moderately loaded server (100 users - 0.4 load avg).
> >>
> >>The server is a Intel STL2 with dual P3, 1GB RAM, Intel Pro1000T
> >>and Qlogic 2300 Fibre channel HBA.
> >>
> >>We are running qla2300, e1000 and lvm modules unmodified as present in
> >>2.4.19pre10aa4. We also have quotas enabled on 1 of the ext3 fs.
> >>
> >
> >
> > It's not familiar, sorry.
> 
> Maybe I should try XFS? I've heard of people running this for
> 80+ days and no downtime. I really would like to get past 8 days.

Well that would be one way of eliminating variables, and that's
the only way to narrow this down.   Looks like something somewhere
(software or hardware) has corrupted some memory.

The problem is that even if you _do_ fix the problem by switching
something out, the cause could lie elsewhere.
