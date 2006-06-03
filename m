Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWFCISD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWFCISD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWFCISC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:18:02 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:62162 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030304AbWFCIR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:17:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch] fix smt nice lock contention and optimization
Date: Sat, 3 Jun 2006 18:17:25 +1000
User-Agent: KMail/1.9.3
Cc: "'Ingo Molnar'" <mingo@elte.hu>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Chris Mason'" <mason@suse.com>, linux-kernel@vger.kernel.org
References: <000801c686e5$666e5f60$df34030a@amr.corp.intel.com>
In-Reply-To: <000801c686e5$666e5f60$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606031817.26018.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 18:12, Chen, Kenneth W wrote:
> Ingo Molnar wrote on Saturday, June 03, 2006 12:58 AM
>
> > * Con Kolivas <kernel@kolivas.org> wrote:
> > > Could we make this neater with extra braces such as:
> > >
> > >  	for_each_domain(this_cpu, tmp) {
> > > 		if (tmp->flags & SD_SHARE_CPUPOWER) {
> > >  			sd = tmp;
> > > 			break;
> > > 		}
> > > 	}
> > >
> > > and same for the other uses of for_each ? I know it's redundant but
> > > it's neater IMO when there are multiple lines of code below it.
> >
> > yep, that's the preferred style when there are multiple lines below a
> > loop.
>
> OK, thanks for the tips.  Here is an incremental coding-style fix:

Great!

Thanks Chris, Nick and Ken for your input.

Signed-off-by: Con Kolivas <kernel@kolivas.org>
for both

-- 
-ck
