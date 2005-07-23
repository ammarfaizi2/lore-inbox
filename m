Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVGWMwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVGWMwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 08:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVGWMwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 08:52:20 -0400
Received: from [216.208.38.107] ([216.208.38.107]:10881 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261609AbVGWMwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 08:52:16 -0400
Subject: Re: [PATCH] Add
	schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
From: Arjan van de Ven <arjan@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
In-Reply-To: <Pine.LNX.4.61.0507231340070.3743@scrub.home>
References: <20050707213138.184888000@homer>
	 <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com>
	 <1122078715.5734.15.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0507231247460.3743@scrub.home>
	 <1122116986.3582.7.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0507231340070.3743@scrub.home>
Content-Type: text/plain
Date: Sat, 23 Jul 2005 08:51:25 -0400
Message-Id: <1122123085.3582.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-23 at 13:55 +0200, Roman Zippel wrote:
> Hi,
> 
> On Sat, 23 Jul 2005, Arjan van de Ven wrote:
> 
> > > What's wrong with using jiffies? 
> > 
> > A lot of the (driver) users want a wallclock based timeout. For that,
> > miliseconds is a more obvious API with less chance to get the jiffies/HZ
> > conversion wrong by the driver writer.
> 
> We have helper functions for that.

I think we just disagree then... I consider this one a helper function
as well, one with a simpler API that wraps the more complex and powerful
api.

Sure sleeps are imprecise. All sleeps are even mdelay() (due to
preemption).


