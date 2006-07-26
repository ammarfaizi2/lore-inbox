Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWGZOju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWGZOju (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWGZOju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:39:50 -0400
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:18627 "EHLO
	mail.lidskialf.net") by vger.kernel.org with ESMTP id S1750738AbWGZOju
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:39:50 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Date: Wed, 26 Jul 2006 15:39:49 +0100
User-Agent: KMail/1.9.3
Cc: David Lang <dlang@digitalinsight.com>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
References: <20060725034247.GA5837@kroah.com> <200607261510.03098.adq_dvb@lidskialf.net> <20060726142932.GE23701@stusta.de>
In-Reply-To: <20060726142932.GE23701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607261539.50492.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 15:29, Adrian Bunk wrote:
> On Wed, Jul 26, 2006 at 03:10:02PM +0100, Andrew de Quincey wrote:
> > On Wednesday 26 July 2006 14:02, Adrian Bunk wrote:
> >...
> >
> > > What bothers me more is that noone tested this patch against the kernel
> > > it was applied against.
> > >
> > > The submitter didn't test it works (he didn't even test the
> > > compilation).
> >
> > Yes I did - I didn't test the final generated patch unfortunately since I
> > assumed it worked. The kernel I _meant_ to diff against worked perfectly
> > :(
>
> Sorry if this was wrong, it wasn't meant against you personally.
>
> Things do go wrong. That's life.
> And you aren't the first person who sent a patch that broke the
> compilation of the next -stable kernel.

thanks. I feel a little bit better :)

> The real problem is:
> How do we get some testing coverage of -stable kernels by users to catch
> issues?
> And compile errors are the least of my worries.

Yeah - I believe some people did test the DVB -stable patches, but obviously 
without the budget-av driver compile option enabled, so it didn't compile 
that code. DVB supports quite a few cards, so its easy to accidentally leave 
off one of the options when doing a mass compile of all drivers.

The only thing I can think of would be to require -stable patch submitters to 
supply a list of CONFIG options that must be on to enable compilation of the 
new code so people know exactly how to enable it for testing... but obviously 
since those would be manually specified, they can be wrong too. But at least 
it would show they'd thought about it a bit....
