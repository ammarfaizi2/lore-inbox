Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266918AbRGHQrs>; Sun, 8 Jul 2001 12:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266919AbRGHQrk>; Sun, 8 Jul 2001 12:47:40 -0400
Received: from [194.213.32.142] ([194.213.32.142]:6660 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266918AbRGHQrY>;
	Sun, 8 Jul 2001 12:47:24 -0400
Date: Sat, 30 Jun 2001 14:24:39 +0000
From: Pavel Machek <pavel@suse.cz>
To: Zach Brown <zab@osdlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cutting up struct kernel_stat into cpu_stat
Message-ID: <20010630142438.A255@toy.ucw.cz>
In-Reply-To: <20010621113107.A16934@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010621113107.A16934@osdlab.org>; from zab@osdlab.org on Thu, Jun 21, 2001 at 11:31:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The attached patch-in-progress removes the per-cpu statistics from
> struct kernel_stat and puts them in a cpu_stat structure, one per cpu,
> cacheline padded.  The data is still coolated and presented through
> /proc/stat, but another file /proc/cpustat is also added.  The locking
> is as nonexistant as it was with kernel_stat, but who cares, they're
> just fuzzy stats to be eyeballed by system tuners :).

Looks good to me... Should improve performance plus adds per-cpu data...


-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

