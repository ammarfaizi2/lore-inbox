Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTDKBht (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 21:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTDKBht (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 21:37:49 -0400
Received: from [12.47.58.73] ([12.47.58.73]:8038 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264290AbTDKBhs (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 21:37:48 -0400
Date: Thu, 10 Apr 2003 18:50:06 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lockmeter 2.5] BKL with 51ms hold time, prove me wrong
Message-Id: <20030410185006.5fd88c30.akpm@digeo.com>
In-Reply-To: <46950000.1050023701@w-hlinder>
References: <46950000.1050023701@w-hlinder>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2003 01:49:24.0140 (UTC) FILETIME=[940286C0:01C2FFCC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder <hannal@us.ibm.com> wrote:
>
> 
> My original purpose was to verify my lockmeter port is producing 
> valid data so I was comparing to readprofile results. However, I saw 
> these high hold times and wanted to show them to you. Here is the 
> whole lockmeter output file: 
> http://prdownloads.sourceforge.net/lse/lockmeter.rmapm
> 
> Below is a snippet of lockmeter data from running Andrew Morton's
> rmap-test -m -i 10 -n 50 -s 600 -t 100 foo
> on a 2-way PIII 256MB RAM 500MHz System

I'm a bit surprised that even slow machine like that would take 50
milliseconds to truncate 128MB of file, but it's not impossible I guess. 
Truncate is not really a fastpath.  ext3 in -mm doesn't have any lock_kernels
in it.

