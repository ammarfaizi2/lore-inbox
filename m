Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132564AbRDAVOq>; Sun, 1 Apr 2001 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132565AbRDAVOg>; Sun, 1 Apr 2001 17:14:36 -0400
Received: from nrg.org ([216.101.165.106]:55397 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132564AbRDAVOV>;
	Sun, 1 Apr 2001 17:14:21 -0400
Date: Sun, 1 Apr 2001 14:13:36 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: george anzinger <george@mvista.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <3AC6DD34.5B030E96@mvista.com>
Message-ID: <Pine.LNX.4.05.10104011408460.14420-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Mar 2001, george anzinger wrote:
> I think this should be:
> 	          if (p->has_cpu || p->state & TASK_PREEMPTED)) {
> to catch tasks that were preempted with other states.

But the other states are all part of the state change that happens at a
non-preemtive schedule() point, aren't they, so those tasks are already
safe to access the data we are protecting.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

