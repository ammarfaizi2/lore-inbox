Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbTBRDbd>; Mon, 17 Feb 2003 22:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbTBRDbd>; Mon, 17 Feb 2003 22:31:33 -0500
Received: from packet.digeo.com ([12.110.80.53]:34723 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267568AbTBRDbd>;
	Mon, 17 Feb 2003 22:31:33 -0500
Date: Mon, 17 Feb 2003 19:42:30 -0800
From: Andrew Morton <akpm@digeo.com>
To: livewire@gentoo.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.62 oops
Message-Id: <20030217194230.7bf6f97b.akpm@digeo.com>
In-Reply-To: <200302172229.21528.livewire@gentoo.org>
References: <200302172229.21528.livewire@gentoo.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Feb 2003 03:41:26.0811 (UTC) FILETIME=[9D8DB6B0:01C2D6FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Johnson <livewire@gentoo.org> wrote:
>
> Running a stress test of 50 concurrent kernel tree cp's + md5sum the files on
> 2.5.62 results in the following:
> 
> Feb 17 21:53:41 livewire kernel: VFS: brelse: Trying to free free buffer
> Feb 17 21:53:41 livewire kernel: buffer layer error at fs/buffer.c:1170
> Feb 17 21:53:41 livewire kernel: Pass this trace through ksymoops for 
> reporting

It's not really an oops, although the bug which this is reporting could cause
a crash.

It is a known problem in the htree indexed directory code.  I can reproduce
it, but haven't had time to work on it.  Chris Li has time to work on it,
but cannot reproduce it.

We'll get there.

