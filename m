Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVDDEZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVDDEZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 00:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVDDEZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 00:25:12 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:41372 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262005AbVDDEZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 00:25:07 -0400
Message-ID: <4250C19F.9070801@myrealbox.com>
Date: Sun, 03 Apr 2005 21:25:03 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@engr.sgi.com>
CC: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
   benchmark result on recent 2.6 kernels]
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>	<20050402145351.GA11601@elte.hu>	<20050402215332.79ff56cc.pj@engr.sgi.com>	<20050403070415.GA18893@elte.hu> <20050403043420.212290a8.pj@engr.sgi.com>
In-Reply-To: <20050403043420.212290a8.pj@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Ok - that flies, or at least walks.  It took 53 seconds to
> compute this cost matrix.

Not that I really know what I'm talking about here, but this sounds 
highly parallelizable.  It seems like you could do N/2 measurements at a 
time, so this should be O(N) to compute the matrix (ignoring issues of 
how long it takes to write the data to memory, but that should be 
insignificant).

Even if you can't parallelize it all the way, it ought to at least help.

--Andy
