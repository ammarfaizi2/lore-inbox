Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUJTSH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUJTSH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268919AbUJTSHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:07:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36253 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268728AbUJTRzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:55:38 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Timothy Miller <miller@techsource.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrea Arcangeli <andrea@novell.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <4176A749.8050306@techsource.com>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <41768858.8070709@techsource.com>
	 <20041020153521.GB21556@devserv.devel.redhat.com>
	 <1098290345.1429.65.camel@krustophenia.net>
	 <4176A749.8050306@techsource.com>
Content-Type: text/plain
Message-Id: <1098294932.1429.153.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 13:55:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 13:58, Timothy Miller wrote:
> Lee Revell wrote:
> > On Wed, 2004-10-20 at 11:35, Arjan van de Ven wrote:
> > 
> >>On Wed, Oct 20, 2004 at 11:46:32AM -0400, Timothy Miller wrote:
> >>
> >>>The rules about how long a hard irq would be allowed to run would have 
> >>>to be draconian.
> >>
> >>they already are.
> > 
> > 
> > The IDE I/O completion in hardirq context means that one can run for
> > almost 3ms.  Apparently at OLS it was decided that the target for
> > desktop responsiveness was 1ms.  So this is a real problem.
> 
> What is happening that takes 3ms, and why can't it be broken up?
> 

http://lkml.org/lkml/2004/7/24/26

> Are you talking here about PIO?  Is there a limited amount of time you 
> have to do the PIO before the data goes away?  It may be acceptable to 
> just live with PIO being slow, since high-performance systems will all 
> be using DMA anyhow.
> 

Nope, DMA.

> > 
> > What exactly do you mean by "draconian"?
> 
> In this case, I mean extremely harsh and restrictive.  Usually, it means 
> "excessively harsh", but in this case, I mean that in a good way.  :)
> 

Heh, I know what the word means, I was asking what the specific rules
are that could be considered as such.

Lee

