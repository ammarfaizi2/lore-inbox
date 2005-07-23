Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVGWNFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVGWNFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 09:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVGWNFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 09:05:16 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31917 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261659AbVGWNFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 09:05:14 -0400
Date: Sat, 23 Jul 2005 15:04:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Arjan van de Ven <arjan@infradead.org>
cc: Nishanth Aravamudan <nacc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}()
 interfaces
In-Reply-To: <1122123085.3582.13.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0507231456000.3728@scrub.home>
References: <20050707213138.184888000@homer>  <20050708160824.10d4b606.akpm@osdl.org>
 <20050723002658.GA4183@us.ibm.com>  <1122078715.5734.15.camel@localhost.localdomain>
  <Pine.LNX.4.61.0507231247460.3743@scrub.home>  <1122116986.3582.7.camel@localhost.localdomain>
  <Pine.LNX.4.61.0507231340070.3743@scrub.home> <1122123085.3582.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Jul 2005, Arjan van de Ven wrote:

> > > > What's wrong with using jiffies? 
> > > 
> > > A lot of the (driver) users want a wallclock based timeout. For that,
> > > miliseconds is a more obvious API with less chance to get the jiffies/HZ
> > > conversion wrong by the driver writer.
> > 
> > We have helper functions for that.
> 
> I think we just disagree then... I consider this one a helper function
> as well, one with a simpler API that wraps the more complex and powerful
> api.

How is it more powerful? The next step in introducing such API is that 
people start complaining, they don't get ms precision, which of course is 
fixed by the next patch, with then results in that the whole timer system 
becomes more complex for a few misguided users.
Keep the thing as simple as possible and jiffies _are_ simple. Please show 
me the problem, that needs to be fixed.

bye, Roman
