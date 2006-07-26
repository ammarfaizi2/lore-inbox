Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWGZPHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWGZPHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWGZPHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:07:34 -0400
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:16354 "EHLO
	mail.lidskialf.net") by vger.kernel.org with ESMTP id S1750758AbWGZPHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:07:33 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Date: Wed, 26 Jul 2006 16:07:33 +0100
User-Agent: KMail/1.9.3
Cc: David Lang <dlang@digitalinsight.com>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
References: <20060725034247.GA5837@kroah.com> <200607261539.50492.adq_dvb@lidskialf.net> <20060726150041.GG23701@stusta.de>
In-Reply-To: <20060726150041.GG23701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607261607.33998.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 16:00, Adrian Bunk wrote:
> On Wed, Jul 26, 2006 at 03:39:49PM +0100, Andrew de Quincey wrote:
> > On Wednesday 26 July 2006 15:29, Adrian Bunk wrote:
> >...
> >
> > > The real problem is:
> > > How do we get some testing coverage of -stable kernels by users to
> > > catch issues?
> > > And compile errors are the least of my worries.
> >
> > Yeah - I believe some people did test the DVB -stable patches, but
> > obviously without the budget-av driver compile option enabled, so it
> > didn't compile that code. DVB supports quite a few cards, so its easy to
> > accidentally leave off one of the options when doing a mass compile of
> > all drivers.
> >
> > The only thing I can think of would be to require -stable patch
> > submitters to supply a list of CONFIG options that must be on to enable
> > compilation of the new code so people know exactly how to enable it for
> > testing... but obviously since those would be manually specified, they
> > can be wrong too. But at least it would show they'd thought about it a
> > bit....
>
> This helps only with compilation errors, which are as I said the least
> of my worries.
>
> But does the hardware driven by this driver work?
> And if it does, is there a bug in the patch that causes the kernel to
> crash after some hours?

That is a major problem with DVB development; no developer has all the 
hardware (in fact there is lots of hardware no developer has regular access 
to). Non-developers do test stuff in our HG repository, but again, the test 
coverage is very quite, since only some people do this, and most 
non-developers have only a few pieces of hardware. 

Many people wait till it comes out in the vanilla kernel... which is why there 
were so many bugfixes from me in 2.6.17.7, as it was the first real test of 
several new features/card supports.
