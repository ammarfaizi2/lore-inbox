Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274819AbTGaRLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274821AbTGaRLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:11:33 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54029 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S274819AbTGaRLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:11:32 -0400
Date: Thu, 31 Jul 2003 13:03:32 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Con Kolivas <kernel@kolivas.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm1 results
In-Reply-To: <200308010113.02866.kernel@kolivas.org>
Message-ID: <Pine.LNX.3.96.1030731125608.5711B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Aug 2003, Con Kolivas wrote:


> > Does this help interactivity a lot, or was it just an experiment?
> > Perhaps it could be less agressive or something?
> 
> Well basically this is a side effect of selecting out the correct cpu hogs in 
> the interactivity estimator. It seems to be working ;-) The more cpu hogs 
> they are the lower dynamic priority (higher number) they get, and the more 
> likely they are to be removed from the active array if they use up their full 
> timeslice. The scheduler in it's current form costs more to resurrect things 
> from the expired array and restart them, and the cpu hogs will have to wait 
> till other less cpu hogging tasks run. 

If that's what it really does, fine. I'm not sure it really finds hogs,
though, or rather "finds only true hogs."

> 
> How do we get around this? I'll be brave here and say I'm not sure we need to, 
> as cpu hogs have a knack of slowing things down for everyone, and it is best 
> not just for interactivity for this to happen, but for fairness.

While this does a good job I'm still worried that we don't have a good
handle on which processes are realy interactive in term of interfacing
with a human. I don't think we can make the scheduler do the right thing
in every case unless it has better information.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

