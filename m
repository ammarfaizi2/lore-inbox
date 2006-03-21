Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWCUWvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWCUWvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWCUWvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:51:05 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:62407 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965133AbWCUWvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:51:04 -0500
Message-ID: <44208355.1080200@bigpond.net.au>
Date: Wed, 22 Mar 2006 09:51:01 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>, bugsplatter@gmail.com
Subject: Re: interactive task starvation
References: <1142592375.7895.43.camel@homer>	 <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer>	 <20060321064723.GH21493@w.ods.org> <1142927498.7667.34.camel@homer>	 <20060321091353.GA25248@w.ods.org> <20060321091422.GA9207@elte.hu>	 <20060321111552.GA25651@w.ods.org> <20060321111850.GA2776@elte.hu>	 <1142942878.7807.9.camel@homer>  <20060321125900.GA25943@w.ods.org> <1142947456.7807.53.camel@homer>
In-Reply-To: <1142947456.7807.53.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 21 Mar 2006 22:51:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Tue, 2006-03-21 at 13:59 +0100, Willy Tarreau wrote:
> 
>>On Tue, Mar 21, 2006 at 01:07:58PM +0100, Mike Galbraith wrote:
> 
> 
>>>I can make the knobs compile time so we don't see random behavior
>>>reports, but I don't think they can be totally eliminated.  Would that
>>>be sufficient?
>>>
>>>If so, the numbers as delivered should be fine for desktop boxen I
>>>think.  People who are building custom kernels can bend to fit as
>>>always.
>>
>>That would suit me perfectly. I think I would set them both to zero.
>>It's not clear to me what workload they can help, it seems that they
>>try to allow a sometimes unfair scheduling.
> 
> 
> Correct.  Massively unfair scheduling is what interactivity requires.
> 

Selective unfairness not massive unfairness is what's required.  The 
hard part is automating the selectiveness especially when there are 
three quite different types of task that need special treatment: 1) the 
X server, 2) normal interactive tasks and 3) media streamers; each of 
which has different behavioural characteristics.  A single mechanism 
that classifies all of these as "interactive" will unfortunately catch a 
lot of tasks that don't belong to any one of these types.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
