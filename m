Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268466AbTBOAbN>; Fri, 14 Feb 2003 19:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268475AbTBOAbN>; Fri, 14 Feb 2003 19:31:13 -0500
Received: from packet.digeo.com ([12.110.80.53]:61317 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268466AbTBOAbM>;
	Fri, 14 Feb 2003 19:31:12 -0500
Date: Fri, 14 Feb 2003 16:39:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: Siim Vahtre <siim@pld.ttu.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swap never cleaned up
Message-Id: <20030214163918.15a7209f.akpm@digeo.com>
In-Reply-To: <Pine.SOL.4.31.0302150140440.28624-100000@pitsa.pld.ttu.ee>
References: <Pine.SOL.4.31.0302150140440.28624-100000@pitsa.pld.ttu.ee>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2003 00:40:48.0520 (UTC) FILETIME=[E2308080:01C2D48A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siim Vahtre <siim@pld.ttu.ee> wrote:
>
> Hi.
> 
> Since moving from 2.5.59 to 2.5.60 I've noticed some strange
> behaviour with swap managment. For some unknown reason the
> swapspace starts to fill up but it will NEVER get freed.
> Hence, it is first time in my life when I actually see swap
> used more than 20M on this computer!

Everything seems OK here, from a quick swap and tmpfs test.

Is it possible that some application is leaking memory, and that
swapoff causes it to be oom-killed?

Take a careful look at the process listing, see if some process is using a
lot of memory.  Also the contents of /proc/meminfo.  And see if you can work
out what operation is causing this.

Thanks.
