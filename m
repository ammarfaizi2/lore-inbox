Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263530AbSIQDLT>; Mon, 16 Sep 2002 23:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263546AbSIQDLT>; Mon, 16 Sep 2002 23:11:19 -0400
Received: from h00010256f583.ne.client2.attbi.com ([66.30.243.14]:16345 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S263530AbSIQDLT>; Mon, 16 Sep 2002 23:11:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Lev Makhlis <mlev@despammed.com>
To: Rik van Riel <riel@conectiva.com.br>, Anton Blanchard <anton@samba.org>
Subject: Re: [despammed] Re: [RFC] [PATCH] [2.5.35] Run Queue Statistics
Date: Mon, 16 Sep 2002 23:20:58 -0400
User-Agent: KMail/1.4.2
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209170007110.1857-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0209170007110.1857-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209162320.58419.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 11:08 pm, Rik van Riel wrote:
> On Tue, 17 Sep 2002, Anton Blanchard wrote:
> > On a semi related note, vmstat wants to know the number of running,
> > blocked and swapped processes. strace vmstat one day and you will see it
> > currently opens /proc/*/stat (ie one open for each process) just to get
> > these stats.  Yet another place where the monitoring utilities disturb
> > the system way too much.
> >
> > Can we get some things in /proc/stat to give us these numbers? Does
> > "swapped" make any sense on Linux?
>
> Runnable can be done currently, blocked on IO is trivial once
> Andrew has pushed the iowait stats to Linus.
>
> Swapped doesn't make any sense at the moment, but it should.
> A system without load control is just too vulnerable to sudden
> load spikes. If Andrew has interest I'll pick up the work I
> did in that area ...
>
> I'll also update vmstat to just use /proc/stat instead of
> looking at all /proc/*/stat files.
>
> cheers,
>
> Rik

Amusingly, the number of running processes can be found in
/proc/loadavg, of all places, right now.
