Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbSJGUKn>; Mon, 7 Oct 2002 16:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262732AbSJGUJe>; Mon, 7 Oct 2002 16:09:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:32950 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262672AbSJGUIv>;
	Mon, 7 Oct 2002 16:08:51 -0400
Message-ID: <3DA1EB1F.C992353@digeo.com>
Date: Mon, 07 Oct 2002 13:14:23 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 
 -  (NUMA))
References: <Pine.LNX.4.33.0210071222340.10168-100000@penguin.transmeta.com> <E17ye5U-0003ul-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2002 20:14:23.0822 (UTC) FILETIME=[20DDA6E0:01C26E3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> This is easy to verify: say you have 100 MB of kernel source stored in, say,
> 50 different clumps on disk.

Disks use segmentation on their readahead buffers.  Typically four-way.
So they will only buffer four different chunks of disk at a time.

If you're reading from 50 different places on disk, the disk keeps
invalidating readahead at the segment level.
