Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282418AbRLKSB6>; Tue, 11 Dec 2001 13:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRLKSBs>; Tue, 11 Dec 2001 13:01:48 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:8977 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282418AbRLKSBi>; Tue, 11 Dec 2001 13:01:38 -0500
Date: Tue, 11 Dec 2001 14:45:16 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <Pine.LNX.4.33L.0112102004490.1352-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0112111441170.26181-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Rik van Riel wrote:

> On Mon, 10 Dec 2001, Andrew Morton wrote:
> 
> > A fix may be to just remove the use-once stuff.  It is one of the
> > sources of this problem, because it's overpopulating the inactive list.
> 
> Absolutely. Use-once is an inherently unstable system, suitable
> for things like a database load (where you know you want to spend
> a certain percentage of your RAM on caching the index), but not
> suitable for a general-purpose VM, where you have no idea how
> large the working set will be.
> 
> I'll take a stab at completely removing the use-once stuff as an
> emergency measure.

Rik,

Could you please make a patch without use-once and post the patch to lkml
?

This way people can test it and report performance results.

I really would prefer to remove use-once as I also think its an
optimization which breaks some workloads, but I want to know what happens
in practice if we do that.

