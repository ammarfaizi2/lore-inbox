Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSFFBGj>; Wed, 5 Jun 2002 21:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSFFBGi>; Wed, 5 Jun 2002 21:06:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64156 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316588AbSFFBGh>;
	Wed, 5 Jun 2002 21:06:37 -0400
To: Rick Bressler <rickb@mushroom.ca.boeing.com>
cc: linux-kernel@vger.kernel.org, rml@tech9.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] scheduler hints 
In-Reply-To: Your message of Wed, 05 Jun 2002 17:46:19 PDT.
             <200206060046.g560kJi04034@mushroom.ca.boeing.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24211.1023325529.1@us.ibm.com>
Date: Wed, 05 Jun 2002 18:05:29 -0700
Message-Id: <E17FliU-0006IZ-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200206060046.g560kJi04034@mushroom.ca.boeing.com>, > : Rick Bressle
r writes:
> > So I went ahead and implemented scheduler hints on top of the O(1)
> > scheduler. 
> 
> > Other hints could be "I am interactive" or "I am a batch (i.e. cpu hog)
> > task" or "I am cache hot: try to keep me on this CPU". 
> 
> Sequent had an interesting hint they cooked up with Oracle. (Or maybe it
> was the other way around.)  As I recall they called it 'twotask.'
> Essentially Oracle clients processes spend a lot of time exchanging
> information with its server process. It usually makes sense to bind them
> to the same CPU in an SMP (and especially NUMA) machine.  (Probably
> obvious to most of the folks on the group, but it is generally lots
> better to essentially communicate through the cache and local memory
> than across the NUMA bus.)

Actually, process-to-process affinity, which was later generalized
as a process gang affinity.

> As I recall it made a significant difference in Oracle performance, and
> would probably also translate to similar performance in many situations
> where you had a client and server process doing lots of interaction in
> an SMP environment.

Yep.  Must be used with care, but not terribly damaging for general
access.   Typically arranged as a many to one linkage by the callers,
which simplified the rebalancing decisions a bit.  I think there
was a paper written about it somewhere by Phil Krueger.

gerrit
