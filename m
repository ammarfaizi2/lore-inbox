Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263172AbTC1WK3>; Fri, 28 Mar 2003 17:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbTC1WK3>; Fri, 28 Mar 2003 17:10:29 -0500
Received: from [12.47.58.223] ([12.47.58.223]:39288 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S263172AbTC1WK2>; Fri, 28 Mar 2003 17:10:28 -0500
Date: Fri, 28 Mar 2003 14:21:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: Craig Dooley <cd5697@albany.edu>
Cc: linux-kernel@vger.kernel.org, Scott Feldman <scott.feldman@intel.com>
Subject: Re: e100 Possible bug
Message-Id: <20030328142138.464e523e.akpm@digeo.com>
In-Reply-To: <200303280918.06787.cd5697@albany.edu>
References: <200303280918.06787.cd5697@albany.edu>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2003 22:21:38.0571 (UTC) FILETIME=[6694E5B0:01C2F578]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Dooley <cd5697@albany.edu> wrote:
>
> Dmesg is filled with errors of slab corruption.  Seems to be e100 related, but 
> maybe alloc_skb.  Dont know the networking code very well.  
> 
> - -Craig
> 
> ## Uname ##
> Linux broken.xlnx-x.net 2.5.66 #1 Thu Mar 27 09:17:40 EST 2003 i686 unknown 
> unknown GNU/Linux
> 
> ## Error ##
> Slab corruption: start=e739b000, expend=e739b7ff, problemat=e739b012
> Data: ******************28 A0 00 00 12 B8 39 27 ****EA C5 F0 05 00 00 08 00 00 
> 00 33 02 ********00 02 B3 46 6E 5D 00 02 B3 46 70 DF 08 00 
> ***************************************************************************

There have been about three reports of this, all against e100.  It does seem
that something in there is altering an skb after it was freed.

