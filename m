Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbSLFIQi>; Fri, 6 Dec 2002 03:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbSLFIQi>; Fri, 6 Dec 2002 03:16:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:1966 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267573AbSLFIQh>;
	Fri, 6 Dec 2002 03:16:37 -0500
Message-ID: <3DF05EA7.4BDCBFF0@digeo.com>
Date: Fri, 06 Dec 2002 00:24:07 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-bk5-wli-1
References: <20021206080009.GB11023@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 08:24:07.0454 (UTC) FILETIME=[D850F3E0:01C29D00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> 2.5.50-wli-bk5-12 resize inode cache wait table -- 8 is too small

Heh.  I decided to make that really, really, really tiny in the expectation
that if it was _too_ small, someone would notice.

For what workload is the 8 too small, and what is the call path
of the waiters?

(If it is `tiobench 100000000' and the wait is in __writeback_single_inode(),
then we should probably just return from there if !sync and the inode is locked)
