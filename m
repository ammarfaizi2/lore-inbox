Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbULTCRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbULTCRF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 21:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbULTCRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 21:17:04 -0500
Received: from fsmlabs.com ([168.103.115.128]:52142 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261380AbULTCRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 21:17:01 -0500
Date: Sun, 19 Dec 2004 19:10:31 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
In-Reply-To: <1103507784.5093.9.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.61.0412191909580.18310@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com>  <20041205232007.7edc4a78.akpm@osdl.org>
  <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com> 
 <20041206160405.GB1271@us.ibm.com>  <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
  <20041206192243.GC1435@us.ibm.com>  <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
  <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com> 
 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com> 
 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com> 
 <29495f1d04121818403f949fdd@mail.gmail.com>  <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
  <1103505344.5093.4.camel@npiggin-nld.site>  <Pine.LNX.4.61.0412191819130.18310@montezuma.fsmlabs.com>
 <1103507784.5093.9.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Nick Piggin wrote:

> On Sun, 2004-12-19 at 18:44 -0700, Zwane Mwaikambo wrote:
> > On Mon, 20 Dec 2004, Nick Piggin wrote:
> > 
> > > This thread can possibly be stalled forever if there is a CPU hog
> > > running, right?
> > 
> > Yep.
> > 
> > > In which case, you will want to use ssleep rather than a busy loop.
> > 
> > Well ssleep essentially does the same thing as the schedule_timeout.
> > 
> 
> Yes - so long as you set ->state when using schedule_timeout ;)

Nish could you please submit something to switch it to ssleep?

Thanks,
	Zwane
