Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267175AbUHTNfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267175AbUHTNfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUHTNfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:35:05 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:18324 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S267175AbUHTNfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:35:00 -0400
Subject: Re: DTrace-like analysis possible with future Linux kernels?
From: Alexander Nyberg <alexn@telia.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Miles Lane <miles.lane@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <87k6vu3bet.fsf@deneb.enyo.de>
References: <200408191822.48297.miles.lane@comcast.net>
	 <87hdqyogp4.fsf@killer.ninja.frodoid.org>  <87k6vu3bet.fsf@deneb.enyo.de>
Content-Type: text/plain
Message-Id: <1093008895.7824.11.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 15:34:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 02:23, Florian Weimer wrote:
> * Julien Oster:
> 
> > Miles Lane <miles.lane@comcast.net> writes:
> >
> >> http://www.theregister.co.uk/2004/07/08/dtrace_user_take/:
> >> "Sun sees DTrace as a big advantage for Solaris over other versions of Unix 
> >> and Linux."
> >
> > That article is way too hypey.
> 
> Maybe, but DTrace seems to solve one really pressing problem: tracking
> disk I/O to the processes causing it.  Unexplained high I/O
> utilization is a *very* common problem, and there aren't any tools to
> diagnose it.
>
> Most other system resources can be tracked quite easily: disk space,
> CPU time, committed address space, even network I/O (with tcpdump and
> netstat -p).  But there's no such thing for disk I/O.

Why can't this be done be looking at the major faults a process causes?

Not very slick indeed, but it can be done.

I wrote a small silly /proc/pid/stat parser at
http://serkiaden.mine.nu/procextract.c 

One could quite easily hack up a tool to monitor I/O per process or
does it need to be very more precise?

