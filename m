Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUHMXBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUHMXBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUHMXBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:01:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:30116 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267661AbUHMXAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:00:20 -0400
Date: Fri, 13 Aug 2004 15:59:45 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Message-ID: <78290000.1092437985@flay>
In-Reply-To: <75260000.1092431774@flay>
References: <200408121646.50740.jbarnes@engr.sgi.com> <200408130859.24637.jbarnes@engr.sgi.com> <89760000.1092414010@[10.10.2.4]> <200408130934.20913.jbarnes@engr.sgi.com> <92140000.1092415652@[10.10.2.4]> <411CFB04.603@yahoo.com.au> <75260000.1092431774@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Well, either we're:
>>> 
>>> 1. Falling back and putting all our most recent accesses off-node.
>>> 
>>> or.
>>> 
>>> 2. Not falling back and only able to use one node's memory for any one 
>>> (single threaded) app.
>>> 
>>> Either situation is crap, though I'm not sure which turd we picked right
>>> now ... I'd have to look at the code again ;-) I thought it was 2, but
>>> I might be wrong.
>>>  
>> 
>> I'm looking at this now. We are doing 1 currently.
> 
> In theory, yes. In practice, I have a feeling kswapd will keep us above
> the level of free memory where we'd fall back to another zone to allocate,
> won't it?

Nope - tested it. Buggered if I can see how that works, but it does ;-)

M.

