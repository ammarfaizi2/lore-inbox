Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268082AbTAJAqn>; Thu, 9 Jan 2003 19:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268083AbTAJAqn>; Thu, 9 Jan 2003 19:46:43 -0500
Received: from holomorphy.com ([66.224.33.161]:51093 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268082AbTAJAqk>;
	Thu, 9 Jan 2003 19:46:40 -0500
Date: Thu, 9 Jan 2003 16:55:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian Tinsley <btinsley@emageon.com>
Cc: Andrew Morton <akpm@digeo.com>, Chris Wood <cwood@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Message-ID: <20030110005510.GH23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian Tinsley <btinsley@emageon.com>,
	Andrew Morton <akpm@digeo.com>, Chris Wood <cwood@xmission.com>,
	linux-kernel@vger.kernel.org
References: <3E1A12B5.4020505@xmission.com> <3E1A16C5.87EDE35A@digeo.com> <3E1DAEAC.4060904@xmission.com> <3E1DD913.2571469F@digeo.com> <20030110002548.GG23814@holomorphy.com> <3E1E175A.1050109@emageon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1E175A.1050109@emageon.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Either pollwait tables (invisible in 2.4 and 2.5), kernel stacks of
>> threads (which don't get pae_pgd's and are hence invisible in 2.4
>> and 2.5), or pagecache, with a much higher likelihood of pagecache.

On Thu, Jan 09, 2003 at 06:44:10PM -0600, Brian Tinsley wrote:
> The "kernel stacks of threads" may have some bearing on my incarnation 
> of this problem. We have several heavily threaded Java applications 
> running at the time the live-locks occur. At our most problematic site, 
> one application has a bug that can cause hundreds of timer threads (I 
> mean like 800 or so!) to be "accidentally" created. This site is 
> scheduled for an upgrade either tonight or tomorrow, so I will leave the 
> system as it is and see if I can still cause the live-lock to manifest 
> itself after the upgrade.

There is no extant implementation of paged stacks yet. I'm working on
a different problem (mem_map on 64GB on 2.5.x). I probably won't have
time to implement it in the near future, I probably won't be doing it
vs. 2.4.x, and I won't have to if someone else does it first.


Bill
