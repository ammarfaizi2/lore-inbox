Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131151AbRCUDge>; Tue, 20 Mar 2001 22:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131152AbRCUDgZ>; Tue, 20 Mar 2001 22:36:25 -0500
Received: from nrg.org ([216.101.165.106]:11632 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131151AbRCUDgJ>;
	Tue, 20 Mar 2001 22:36:09 -0500
Date: Tue, 20 Mar 2001 19:35:17 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Keith Owens <kaos@ocs.com.au>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: <16074.985137800@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Keith Owens wrote:
> I misread the code, but the idea is still correct.  Add a preemption
> depth counter to each cpu, when you schedule and the depth is zero then
> you know that the cpu is no longer holding any references to quiesced
> structures.

A task that has been preempted is on the run queue and can be
rescheduled on a different CPU, so I can't see how a per-CPU counter
would work.  It seems to me that you would need a per run queue
counter, like the example I gave in a previous posting.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

