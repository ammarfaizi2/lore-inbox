Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTAaSyz>; Fri, 31 Jan 2003 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbTAaSyz>; Fri, 31 Jan 2003 13:54:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:36322 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261874AbTAaSyy>;
	Fri, 31 Jan 2003 13:54:54 -0500
Date: Fri, 31 Jan 2003 11:04:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hans Reiser <reiser@namesys.com>
Cc: conman@kolivas.net, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Message-Id: <20030131110417.0b70858a.akpm@digeo.com>
In-Reply-To: <3E3A7C22.1080709@namesys.com>
References: <200302010020.34119.conman@kolivas.net>
	<3E3A7C22.1080709@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2003 19:04:13.0224 (UTC) FILETIME=[8B126280:01C2C95B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> compilation is not an effective benchmark anymore, not for Linux 
> filesystems, they are all just too fast (or is it that the compilers are 
> too slow?....)
> 

The point of this test is to measure interactions, and fairness.

It answers the question "how much impact does heavy filesystem I/O have upon
other system activity?".

The "other system activity" in this test is a kernel compile.  That is a
fairly reasonable metric, because it is sensitive to latencies in servicing
reads and it is sensitive to inappropriate page replacement decisions.

A more appropriate foreground load might be opening a word processor and
composing a short letter to Aunt Nellie, but that's harder to automate.  We
expect that reduced kernel compilation time will correlate with lower-latency
letter writing.

