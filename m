Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTAYCRm>; Fri, 24 Jan 2003 21:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266078AbTAYCRm>; Fri, 24 Jan 2003 21:17:42 -0500
Received: from bitmover.com ([192.132.92.2]:59094 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266064AbTAYCRm>;
	Fri, 24 Jan 2003 21:17:42 -0500
Date: Fri, 24 Jan 2003 18:26:48 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jason Papadopoulos <jasonp@boo.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: your mail
Message-ID: <20030125022648.GA13989@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jason Papadopoulos <jasonp@boo.net>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.44.0301232104440.10187-100000@dlang.diginsite.com> <40475.210.212.228.78.1043384883.webmail@mail.nitc.ac.in> <Pine.LNX.4.44.0301232104440.10187-100000@dlang.diginsite.com> <3.0.6.32.20030124212935.007fcc10@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.6.32.20030124212935.007fcc10@boo.net>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For the record, I finally got to try my own page coloring patch on a 1GHz
> Athlon Thunderbird system with 256kB L2 cache. With the present patch, my
> own number crunching benchmarks and a kernel compile don't show any benefit 
> at all, and lmbench is completely unchanged except for the mmap latency, 
> which is slightly worse. Hardly a compelling case for PCs!

If it works correctly then the variability in lat_ctx should go away.
Try this

	for p in 2 4 8 12 16 24 32 64
	do	for size in 0 2 4 8 16
		do	for i in 1 2 3 4 5 6 7 8 9 0
			do	lat_ctx -s$size $p
			done
		done
	done

on both the with and without kernel.  The page coloring should make the 
numbers rock steady, without it, they will bounce a lot.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
