Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbTCOMPV>; Sat, 15 Mar 2003 07:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbTCOMPU>; Sat, 15 Mar 2003 07:15:20 -0500
Received: from holomorphy.com ([66.224.33.161]:42193 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261432AbTCOMPU>;
	Sat, 15 Mar 2003 07:15:20 -0500
Date: Sat, 15 Mar 2003 04:25:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: bzzz@tmi.comex.ru, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hawkes@sgi.com, hannal@us.ibm.com
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030315122547.GV20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, hawkes@sgi.com, hannal@us.ibm.com
References: <20030315043744.GM1399@holomorphy.com> <20030314205455.49f834c2.akpm@digeo.com> <20030315054910.GN20188@holomorphy.com> <20030315062025.GP20188@holomorphy.com> <20030314224413.6a1fc39c.akpm@digeo.com> <20030315070511.GQ20188@holomorphy.com> <20030315082431.GG5891@holomorphy.com> <20030315094758.GT20188@holomorphy.com> <20030315115856.GU20188@holomorphy.com> <20030315040819.1d7e43c6.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315040819.1d7e43c6.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 12:24:31AM -0800, William Lee Irwin III wrote:
>> Okay, dump_stack() every once in a while when we schedule() in down().

On Sat, Mar 15, 2003 at 04:08:19AM -0800, Andrew Morton wrote:
> Thanks.

No problem. I think we found out a number of things that help everyone.


On Sat, Mar 15, 2003 at 12:24:31AM -0800, William Lee Irwin III wrote:
>> No good ideas how to script the results so I have the foggiest idea
>> who's the bad guy. gzipped and MIME attached (Sorry!) for space reasons.

On Sat, Mar 15, 2003 at 04:08:19AM -0800, Andrew Morton wrote:
> lock_super() in the ext2 inode allocator mainly.  It needs the same treatment.

Terrific! Not only have we resolved 16x ext2 contention issues we've
also identified a clear direction for 32x!!

Go fs hackers go! First 2.5 VM, now 2.6/2.7 VFS. What can't you do?


-- wli
