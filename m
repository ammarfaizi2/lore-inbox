Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUIBWRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUIBWRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269177AbUIBWPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:15:21 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:42726 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S269147AbUIBVW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:22:28 -0400
Message-ID: <41378EB9.2060508@colorfullife.com>
Date: Thu, 02 Sep 2004 23:20:57 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jim.houston@comcast.net
CC: paulmck@us.ibm.com, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jack Steiner <steiner@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       rusty@rustcorp.com.au
Subject: Re: [RFC&PATCH] Alternative RCU implementation
References: <m3brgwgi30.fsf@new.localdomain>	 <20040830004322.GA2060@us.ibm.com>	 <1093886020.984.238.camel@new.localdomain>	 <20040830185223.GF1243@us.ibm.com>	 <1093922569.1003.159.camel@new.localdomain>	 <20040901035350.GH1241@us.ibm.com>	 <1094043719.986.51.camel@new.localdomain>	 <20040902163854.GC1258@us.ibm.com> <1094151272.985.103.camel@new.localdomain>
In-Reply-To: <1094151272.985.103.camel@new.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:

>We add the following /proc files:
>
>/proc/shield/irqs
>	Setting a bit limits the corresponding cpu to only handle
>	interrupts which are explicitly directed to that cpu.
>
>/proc/shield/ltmrs
>	Setting a bit limits the use of local timers on the 
>	corresponding cpu.
>
>  
>
How do you handle schedule_delayed_work_on()?
slab uses it to drain the per-cpu caches. It's not fatal if a cpu 
doesn't drain it's caches (just some wasted memory), but it should be 
documented.

--
    Manfred
