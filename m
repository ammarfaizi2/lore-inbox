Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTJAFSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTJAFSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:18:33 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:41442 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S261914AbTJAFSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:18:32 -0400
Date: Wed, 1 Oct 2003 01:18:27 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 scheduling(?) oddness
Message-ID: <20031001051827.GE1416@Master>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031001032238.GB1416@Master> <20030930215512.1df59be3.akpm@osdl.org> <3F7A604F.1060905@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7A604F.1060905@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 03:04:15PM +1000, Nick Piggin wrote:
> 
> 
> Andrew Morton wrote:
> 
> >"Murray J. Root" <murrayr@brain.org> wrote:
> >
> >>The render finishes in the same 30 minutes, then oowriter starts.
> >>oowriter takes about 3 seconds to load if no rendering is going on.
> >>
> >
> >OpenOffice uses sched_yield() in strange ways which causes it to
> >get hopelessly starved on 2.6 kernels.  I think RH have a fixed version,
> >but I don't know if that has propagated into the upstream yet.
> >
> >
> 
> OK. Aside from the OpenOffice issue, you still have povray taking 50%
> longer to complete, which is quite remarkable if its single threaded and
> nothing else is running. Maybe its not the scheduler change? Anyway,
> Con will want to know exactly which version of his scheduler you used in
> test5 to check for possibilities.
> 
 
 patch-test5-O20int 
 
Not sure what caused the increase from 2.6.0-test5 to 2.6.0-test6.
One noticeable thing - I get a noticeable speed increase if I turn off
rendering to the screen, so that it only goes to a file. I don't get
that speed improvement in 2.5.65 - only in 2.6.0-test5 and 2.6.0-test6
test5 goes from 20 mins to about 15 mins (the same speed as 2.5.65 with
or without screen rendering)
test6 goes from 30 mins to 24 mins - still worse than test5 by a lot.

-- 
Murray J. Root

