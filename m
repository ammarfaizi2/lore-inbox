Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSIWSbe>; Mon, 23 Sep 2002 14:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbSIWSad>; Mon, 23 Sep 2002 14:30:33 -0400
Received: from packet.digeo.com ([12.110.80.53]:57224 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261385AbSIWS32>;
	Mon, 23 Sep 2002 14:29:28 -0400
Message-ID: <3D8F5C41.35EBE979@digeo.com>
Date: Mon, 23 Sep 2002 11:24:01 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Con Kolivas <conman@kolivas.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.4.44.0209230945260.2917-100000@localhost.localdomain> <1032777021.3d8eed3d55f53@kolivas.net> <20020923124730.GA7556@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 18:24:01.0820 (UTC) FILETIME=[640FD5C0:01C2632E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> 
> On Mon Sep 23, 2002 at 08:30:21PM +1000, Con Kolivas wrote:
> > Yes you make a very valid point and something I've been stewing over privately
> > for some time. contest runs benchmarks in a fixed order with a "priming" compile
> > to try and get pagecaches etc back to some sort of baseline (I've been trying
> > hard to make the results accurate and repeatable).
> 
> It would sure be nice for this sortof test if there were
> some sort of a "flush-all-caches" syscall...
> 

Yes, it would be nice.

Unmounting and remounting the test filesystem is usually
sufficient.  Or you can run

main()
{
	memset(malloc(1024*1024*1024), 0, 1024*1024*1024);
}

a couple of times.
