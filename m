Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263524AbSIQC7T>; Mon, 16 Sep 2002 22:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263530AbSIQC7T>; Mon, 16 Sep 2002 22:59:19 -0400
Received: from dp.samba.org ([66.70.73.150]:908 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263524AbSIQC7S>;
	Mon, 16 Sep 2002 22:59:18 -0400
Date: Tue, 17 Sep 2002 12:59:08 +1000
From: Anton Blanchard <anton@samba.org>
To: Lev Makhlis <mlev@despammed.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, riel@conectiva.com.br
Subject: Re: [RFC] [PATCH] [2.5.35] Run Queue Statistics
Message-ID: <20020917025907.GB15189@krispykreme>
References: <200209161820.44702.mlev@despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209161820.44702.mlev@despammed.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> This patch adds two counters, runque and runocc, similar to those
> in traditional UNIX systems, to measure the run queue occupancy.
> Every second, 'runque' is incremented by the run queue size, and
> 'runocc' is incremented by one if the run queue is not empty.
> 
> I am not comfortable about putting the calculation in the same function
> as the load average calculation, but I didn't want to call
> count_active_tasks() twice. Comments are welcome.

On a semi related note, vmstat wants to know the number of running,
blocked and swapped processes. strace vmstat one day and you will see it
currently opens /proc/*/stat (ie one open for each process) just to get
these stats.  Yet another place where the monitoring utilities disturb
the system way too much.

Can we get some things in /proc/stat to give us these numbers? Does
"swapped" make any sense on Linux?

Anton
