Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261986AbSIYOrq>; Wed, 25 Sep 2002 10:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbSIYOrq>; Wed, 25 Sep 2002 10:47:46 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:18887 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261986AbSIYOrp>; Wed, 25 Sep 2002 10:47:45 -0400
Date: Wed, 25 Sep 2002 11:52:35 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Con Kolivas <conman@kolivas.net>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] fork_load module tested for contest
In-Reply-To: <1032964936.3d91cb48b1cca@kolivas.net>
Message-ID: <Pine.LNX.4.44L.0209251151220.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Con Kolivas wrote:

> I've been trialling a new load module for the contest benchmark
> (http://contest.kolivas.net) which simply forks a process that does
> nothing, waits for it to die, then repeats. Here are the results I have
> obtained so far:

> fork_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  100.05          69%             1.37
> 2.4.19-ck7              74.65           95%             1.02
> 2.5.38                  77.35           95%             1.06
> 2.5.38-mm2              76.99           95%             1.06
>
> ck7 uses O1, preempt, low latency

Looks like the O(1) scheduler has a problem, then.  The continuous
fork() loop should get 20% of the CPU, not 5%.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

