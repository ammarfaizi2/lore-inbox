Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbTAXFPU>; Fri, 24 Jan 2003 00:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTAXFPU>; Fri, 24 Jan 2003 00:15:20 -0500
Received: from [209.195.52.120] ([209.195.52.120]:49808 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S267541AbTAXFPT>; Fri, 24 Jan 2003 00:15:19 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Anoop J." <cs99001@nitc.ac.in>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Thu, 23 Jan 2003 21:11:10 -0800 (PST)
Subject: Re: your mail
In-Reply-To: <40475.210.212.228.78.1043384883.webmail@mail.nitc.ac.in>
Message-ID: <Pine.LNX.4.44.0301232104440.10187-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The idea of page coloring is based on the fact that common implementations
of caching can't put any page in memory in any line in the cache (such an
implementation is possible, but is more expensive to do so is not commonly
done)

With this implementation it means that if your program happens to use
memory that cannot be mapped to half of the cache lines then effectivly
the CPU cache is half it's rated size for your program. the next time your
program runs it may get a more favorable memory allocation and be able to
use all of the cache and therefor run faster.

Page coloring is an attampt to take this into account when allocating
memory to programs so that every program gets to use all of the cache.

David Lang


 On Fri, 24 Jan 2003, Anoop J. wrote:

> Date: Fri, 24 Jan 2003 10:38:03 +0530 (IST)
> From: Anoop J. <cs99001@nitc.ac.in>
> To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
>
>
> How does page coloring work. Iwant its mechanism not the implementation.
> I went through some pages of W.L.Lynch's paper on cache and VM. Still not
> able to grasp it .
>
>
> Thanks in advance
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
