Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUHUUj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUHUUj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267812AbUHUUj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:39:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36821 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267806AbUHUUjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:39:54 -0400
Date: Wed, 18 Aug 2004 15:18:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-390@vm.marist.edu, arjanv@redhat.com,
       tim.bird@am.sony.com, mulix@mulix.org, alan@redhat.com, crisw@osdl.org,
       jan.glauber@de.ibm.com
Subject: Re: [PATCH] timer (6/6): add cpu steal time fields to procps.
Message-ID: <20040818131839.GI467@openzaurus.ucw.cz>
References: <20040805180557.GG9240@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805180557.GG9240@mschwid3.boeblingen.de.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [PATCH] timer (6/6): add cpu steal time fields to procps.
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Make use of the cpu steal time field in /proc/stat that has been
> introduces by the cputime patch. The new output of top looks like
> this:
> 
> top - 09:50:20 up 11 min,  3 users,  load average: 8.94, 7.17, 3.82
> Tasks:  78 total,   8 running,  70 sleeping,   0 stopped,   0 zombie
>  Cpu0 : 38.7%us,  4.2%sy,  0.0%ni,  0.0%id,  2.4%wa,  1.8%hi,  0.0%si, 53.0%st
>  Cpu1 : 38.5%us,  0.6%sy,  0.0%ni,  5.1%id,  1.3%wa,  1.9%hi,  0.0%si, 52.6%st
>  Cpu2 : 54.0%us,  0.6%sy,  0.0%ni,  0.6%id,  4.9%wa,  1.2%hi,  0.0%si, 38.7%st
>  Cpu3 : 49.1%us,  0.6%sy,  0.0%ni,  1.2%id,  0.0%wa,  0.0%hi,  0.0%si, 49.1%st
>  Cpu4 : 35.9%us,  1.2%sy,  0.0%ni, 15.0%id,  0.6%wa,  1.8%hi,  0.0%si, 45.5%s
>  Cpu5 : 43.0%us,  2.1%sy,  0.7%ni,  0.0%id,  4.2%wa,  1.4%hi,  0.0%si, 48.6%st
> Mem:    251832k total,   155448k used,    96384k free,     1212k buffers
> Swap:   524248k total,    17716k used,   506532k free,    18096k cached



You really need to write nice description into Documentation describing what cpu steal
time is. Will it be always 0 on  non-virtualized machines?
What about hyperthreading?



-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

