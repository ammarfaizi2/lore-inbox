Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263502AbTC3Cez>; Sat, 29 Mar 2003 21:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263504AbTC3Cez>; Sat, 29 Mar 2003 21:34:55 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23568
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263502AbTC3Cey>; Sat, 29 Mar 2003 21:34:54 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Robert Love <rml@tech9.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200303301233.03803.kernel@kolivas.org>
References: <3E8610EA.8080309@telia.com> <1048987260.679.7.camel@teapot>
	 <1048989922.13757.20.camel@localhost>
	 <200303301233.03803.kernel@kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048992365.13757.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 29 Mar 2003 21:46:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 21:33, Con Kolivas wrote:

> Are you sure this should be called a bug? Basically X is an interactive 
> process. If it now is "interactive for a priority -10 process" then it should 
> be hogging the cpu time no? The priority -10 was a workaround for lack of 
> interactivity estimation on the old scheduler.

Well, I do not necessarily think that renicing X is the problem.  Just
an idea.

We do have a problem, though.  Nearly indefinite starvation and all sort
of weird effects like bash not able to create a new process... its a
bug.

Renicing X, aside from some weird client-server starvation issues with
stuff like multimedia programs, should not cause any problem.  It should
help, in fact.  But, you are right, its not needed in the current
scheduler.

	Robert Love

