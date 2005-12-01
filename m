Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVLASZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVLASZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 13:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVLASZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 13:25:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:36059 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932398AbVLASZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 13:25:49 -0500
Subject: Re: Better pagecache statistics ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201181525.GB17169@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain>
	 <20051201152029.GA14499@dmt.cnet>
	 <1133452790.27824.117.camel@localhost.localdomain>
	 <20051201171938.GB16235@dmt.cnet>
	 <1133458309.21429.36.camel@localhost.localdomain>
	 <20051201181525.GB17169@dmt.cnet>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 10:25:59 -0800
Message-Id: <1133461559.21429.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 16:15 -0200, Marcelo Tosatti wrote:
> > > I thought that it would be easy to use SystemTap for a such
> > > a purpose?
> > > 
> > > The sys_read/sys_write example at 
> > > http://www.redhat.com/magazine/011sep05/features/systemtap/ sounds
> > > interesting.
> > > 
> > > What I'm I missing?
> > 
> > Well, Few things:
> > 
> > 1) We have to have those probes present in the system all the time
> > collecting the information when read/write happens, maintaining it
> > and spitting it out. Since its kernel probe, all this data will be
> > in the kernel. 
> 
> Yeah, there is some overhead.
> 
> > 2) If we want to do this accounting (and you don't have those probes
> > installed already) - we can't capture what happened earlier. 
> 
> I suppose that the vast majority of situations where such information is 
> needed are special anyway? 
> 
> Why do you need it around all the time?

Otherwise, we need to insert hooks and ask the customer to reproduce
the problem :(

> > 3) probing sys_read/sys_write() are going to tell you how much
> > a data a process did read or wrote - but its not going to tell you
> > how much is in the cache (now or 10 minutes later). 
> 
> Sure, that was just an example - need to insert probes
> on the correct places.


Okay, I miss understood.


Thanks,
Badari

