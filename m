Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbULTCbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbULTCbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 21:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbULTCbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 21:31:08 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:19153 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261395AbULTCau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 21:30:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Xwl2oJQKxWiKdtR5Pquauonnld2MSAB/lN3qHB3MHrq8b+Rv7U+kklzUPrki5T0oUBBbfxP4bUnXXlwMc+hiV+ZK5unpYhBdFkdWwy1BbEW3cCyzHbOKyzK8PcfsTj5ItxvzXbIvW+J4xgvSOQey5Xczgr64u6p5k5mMRGWSEG8=
Message-ID: <29495f1d04121918305f577eb7@mail.gmail.com>
Date: Sun, 19 Dec 2004 18:30:47 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.61.0412191909580.18310@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041205004557.GA2028@us.ibm.com>
	 <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
	 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
	 <29495f1d04121818403f949fdd@mail.gmail.com>
	 <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
	 <1103505344.5093.4.camel@npiggin-nld.site>
	 <Pine.LNX.4.61.0412191819130.18310@montezuma.fsmlabs.com>
	 <1103507784.5093.9.camel@npiggin-nld.site>
	 <Pine.LNX.4.61.0412191909580.18310@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2004 19:10:31 -0700 (MST), Zwane Mwaikambo
<zwane@arm.linux.org.uk> wrote:
> On Mon, 20 Dec 2004, Nick Piggin wrote:
> 
> > On Sun, 2004-12-19 at 18:44 -0700, Zwane Mwaikambo wrote:
> > > On Mon, 20 Dec 2004, Nick Piggin wrote:
> > >
> > > > This thread can possibly be stalled forever if there is a CPU hog
> > > > running, right?
> > >
> > > Yep.
> > >
> > > > In which case, you will want to use ssleep rather than a busy loop.
> > >
> > > Well ssleep essentially does the same thing as the schedule_timeout.
> > >
> >
> > Yes - so long as you set ->state when using schedule_timeout ;)
> 
> Nish could you please submit something to switch it to ssleep?

Yup, I'll send it out tomorrow.

-Nish
