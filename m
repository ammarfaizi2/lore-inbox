Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288354AbSAHVRG>; Tue, 8 Jan 2002 16:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288351AbSAHVQ4>; Tue, 8 Jan 2002 16:16:56 -0500
Received: from zero.tech9.net ([209.61.188.187]:37384 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288333AbSAHVQl>;
	Tue, 8 Jan 2002 16:16:41 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrew Morton <akpm@zip.com.au>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16O3L5-0000B8-00@starship.berlin>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org>
	<E16Nxjg-00009W-00@starship.berlin> <3C3B4CB7.FEAAF5FC@zip.com.au> 
	<E16O3L5-0000B8-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 16:17:32 -0500
Message-Id: <1010524653.3225.109.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 15:59, Daniel Phillips wrote:

> And while I'm enumerating differences, the preemptable kernel (in this 
> incarnation) has a slight per-spinlock cost, while the non-preemptable kernel 
> has the fixed cost of checking for rescheduling, at intervals throughout all 
> 'interesting' kernel code, essentially all long-running loops.  But by clever 
> coding it's possible to finesse away almost all the overhead of those loop 
> checks, so in the end, the non-preemptible low-latency patch has a slight 
> efficiency advantage here, with emphasis on 'slight'.

True (re spinlock weight in preemptible kernel) but how is that not
comparable to explicit scheduling points?  Worse, the preempt-kernel
typically does its preemption on a branch on return to interrupt
(similar to user space's preemption).  What better time to check and
reschedule if needed?

	Robert Love

