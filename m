Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVAHOI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVAHOI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 09:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVAHOIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 09:08:55 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:22687 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261171AbVAHOIy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 09:08:54 -0500
Message-ID: <41DFE8B7.9070909@andrew.cmu.edu>
Date: Sat, 08 Jan 2005 09:05:43 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jake Moilanen <moilanen@austin.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/4][RFC] Genetic Algorithm Library
References: <20050106100844.53a762a0@localhost>
In-Reply-To: <20050106100844.53a762a0@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have any crossover?  This is critical for GA to work well - 
without it, the algorithm is really only a parallel random search.  More 
specifically, is step 6 pure copies of a single parents, or can children 
inherit tunables from multiple parents?
  - Jim

Jake Moilanen wrote:
> ...
> The basic flow of the genetic algorithm is as follows:
> 
> 1.) Start w/ a broad list of initial tunable values (each set of
> 	tunables is called a child) 
> 2.) Let each child run for a timeslice. 
> 3.) Once the timeslice is up, calculate the fitness of the child (how
> well performed).
> 4.) Run the next child in the list.
> 5.) Once all the children have run, compare the fitnesses of each child
> 	and throw away the bottom-half performers. 
> 6.) Create new children to take the place of the bottom-half performers
> 	using the tunables from the top-half performers.
> 7.) Mutate a set number of children to keep variance.
> 8.) Goto step 2.
> 
> Over time the tunables should converge toward the optimal settings for
> that workload.  If the workload changes, the tunables should converge to
> the new optimal settings (this is part of the reason for mutation). 
> This algorithm is used extensively in AI.
 > ...
