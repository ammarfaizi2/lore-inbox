Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTE1WFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTE1WFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:05:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56580 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261245AbTE1WFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:05:40 -0400
Date: Wed, 28 May 2003 18:12:59 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Olivier Galibert <galibert@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
In-Reply-To: <20030521135154.GA15462@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.3.96.1030528180909.21414B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003, Olivier Galibert wrote:

> On Wed, May 21, 2003 at 03:12:12PM +0200, Arjan van de Ven wrote:
> > if you had spent the time you spent on this colorful graphic on reading
> > SUS or Posix about what sched_yield() means, you would actually have
> > learned something. sched_yield() means "I'm the least important thing in
> > the system".
> 
> Susv2:
> 
> DESCRIPTION
> 
>  The sched_yield() function forces the running thread to relinquish
>  the processor until it again becomes the head of its thread list. It
>  takes no arguments.
> 
> 
> Aka "I skip the rest of my turn, try the others again once", not "I'm
> unimportant" nor "please rerun me immediatly".
> 
> What is it with you people wanting to make sched_yield() unusable for
> anything that makes sense?

Have to agree, I have a context switching benchmark which uses a spinlock
in shared memory for do-it-yourself gating, and it wants sched_yeild() to
be useful on uni. The SuS is pretty clear about this, the useful behaviour
is also the required behaviour, why are people resisting doing it that
way? 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

