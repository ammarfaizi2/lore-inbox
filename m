Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTDNVsU (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTDNVrs (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:47:48 -0400
Received: from [12.47.58.203] ([12.47.58.203]:39941 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263982AbTDNVrb (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:47:31 -0400
Date: Mon, 14 Apr 2003 14:58:52 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blockgroup_lock: hashed spinlocks for ext2 and ext3
Message-Id: <20030414145852.6beabadf.akpm@digeo.com>
In-Reply-To: <20030414214608.GA3392@wotan.suse.de>
References: <200304131113.h3DBDvj2004773@hera.kernel.org>
	<1050350782.7912.400.camel@averell>
	<20030414143813.329609a6.akpm@digeo.com>
	<20030414214608.GA3392@wotan.suse.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 21:59:16.0340 (UTC) FILETIME=[17927340:01C302D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > 
> > And this hashed lock is not a per-cpu thing.  (No locks are!) It just uses
> > NR_CPUS to decide how big the hash should be.
> 
> Isn't that what the IBM kmalloc_per_cpu() was for ? (I think the patch
> was from Dipankar) 

This is not a per-cpu data structure.

It is a hashed spinlock which uses NR_CPUS as a sizing hint.

