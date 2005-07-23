Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVGWNdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVGWNdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 09:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVGWNdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 09:33:20 -0400
Received: from [216.208.38.107] ([216.208.38.107]:30858 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261696AbVGWNdT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 09:33:19 -0400
Subject: Re: [PATCH] Add
	schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
From: Arjan van de Ven <arjan@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
In-Reply-To: <Pine.LNX.4.61.0507231524430.3743@scrub.home>
References: <20050707213138.184888000@homer>
	 <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com>
	 <1122078715.5734.15.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0507231247460.3743@scrub.home>
	 <1122116986.3582.7.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0507231340070.3743@scrub.home>
	 <1122123085.3582.13.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0507231456000.3728@scrub.home>
	 <1122124324.3582.15.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0507231524430.3743@scrub.home>
Content-Type: text/plain
Date: Sat, 23 Jul 2005 09:32:35 -0400
Message-Id: <1122125555.3582.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-23 at 15:29 +0200, Roman Zippel wrote:
> Hi,
> 
> On Sat, 23 Jul 2005, Arjan van de Ven wrote:
> 
> > jiffies/HZ is the more powerful API. The msec one which also sets
> > current to (un)interruptible is the simplified wrapper on top.
> 
> So why do you want to hide it? 

I don't want to hide it at all. I want to provide a simpler variant for
it for the cases where a simpler variant is enough. It really is a
helper to take some common task and get that closer to what the
programmer wants (wallclock time delay)

