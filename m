Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUI2TkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUI2TkI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUI2Thu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:37:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52683 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267703AbUI2TgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:36:16 -0400
Date: Wed, 29 Sep 2004 12:34:47 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant CLOCK_PROCESS/THREAD_CPUTIME_ID V4
In-Reply-To: <415B0C9E.5060000@mvista.com>
Message-ID: <Pine.LNX.4.58.0409291233500.25905@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
 <415B0C9E.5060000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, George Anzinger wrote:

> > So restrict timer_create to CLOCK_REALTIME and CLOCK_MONOTONIC? Is it
> > necessary to be able to derive a timer from a timer derives from those
> > two?
> >
> > something like the following (just inlined for the discussion ...)?
>
> NO.  This is handled through the dispatch table (as set up when you register the
> clock).  You just supply a timer_create() function that returns the right error.
>   Likewise, attempts to use clock_nanosleep().  The issue with clock_nanosleep,
> however, is that it, at this time, is not sent through the dispatch table.  This
> should be changed to, again call the same error function.

Ok. I gotta look at this again.

