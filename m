Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWCAVVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWCAVVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWCAVVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:21:43 -0500
Received: from mail.suse.de ([195.135.220.2]:39651 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751922AbWCAVVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:21:43 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Date: Wed, 1 Mar 2006 22:21:36 +0100
User-Agent: KMail/1.9.1
Cc: clameter@engr.sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com> <200603012159.42273.ak@suse.de> <20060301131910.beb949be.pj@sgi.com>
In-Reply-To: <20060301131910.beb949be.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603012221.37271.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 22:19, Paul Jackson wrote:

> 
> > If something is a good default it shouldn't need user space
> > configuration at all imho. Only the "weird" cases should.
> 
> So are you just saying we got the default backwards?

Yes.

> But for the SGI systems I care about, I'd prefer the default to be
> spreading them.

I think it's the best default for smaller systems too. I've had people
complaining about node inbalances that were caused by one or two
being filled up with d/icache. And the small latencies of accessing
them don't matter very much.

> If you think it would be better to change this default, now that the
> mechanism is in place to do support spreading these slabs, then I could
> certainly go along with that.

Yes that would make me happy.
 
> Then your systems would not have to do anything in user space, unless
> they wanted to disable spreading these slabs (which of course they
> could easily do using cpusets ;).
> 
>     Should we change the default to enable this spreading?

I would be in favour of it

-Andi

