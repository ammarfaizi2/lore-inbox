Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131454AbRCWUnV>; Fri, 23 Mar 2001 15:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRCWUnL>; Fri, 23 Mar 2001 15:43:11 -0500
Received: from nrg.org ([216.101.165.106]:20275 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131446AbRCWUm7>;
	Fri, 23 Mar 2001 15:42:59 -0500
Date: Fri, 23 Mar 2001 12:42:01 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Rusty Russell <rusty@rustcorp.com.au>
cc: george anzinger <george@mvista.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <m14fjfA-001PKRC@mozart>
Message-ID: <Pine.LNX.4.05.10103231215540.5839-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Rusty Russell wrote:
> Nigel's "traverse the run queue and mark the preempted" solution is
> actually pretty nice, and cheap.  Since the runqueue lock is grabbed,
> it doesn't require icky atomic ops, either.

You'd have to mark both the preempted tasks, and the tasks currently
running on each CPU (which could become preempted before reaching a
voluntary schedule point).

> Despite Nigel's initial belief that this technique is fragile, I
> believe it will become an increasingly fundamental method in the
> kernel, so (with documentation) it will become widely understood, as
> it offers scalability and efficiency.

Actually, I agree with you now that I've had a chance to think about
this some more.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

