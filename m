Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWCWDWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWCWDWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWCWDWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:22:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:13703 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932154AbWCWDWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:22:44 -0500
X-Authenticated: #14349625
Subject: Re: [interbench numbers] Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <willy@w.ods.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com, Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200603230727.51235.kernel@kolivas.org>
References: <1142592375.7895.43.camel@homer>
	 <1142999382.11047.34.camel@homer> <1143029650.8298.18.camel@homer>
	 <200603230727.51235.kernel@kolivas.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 04:22:58 +0100
Message-Id: <1143084178.7665.6.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 07:27 +1100, Con Kolivas wrote:
> On Wednesday 22 March 2006 23:14, Mike Galbraith wrote:
> > Greetings,
> >
> > I was asked to do some interbench runs, with various throttle settings,
> > see below.  I'll not attempt to interpret results, only present raw data
> > for others to examine.
> >
> > Tested throttling patches version is V24, because while I was compiling
> > 2.6.16-rc6-mm2 in preparation for comparison, I found I'd introduced an
> > SMP buglet in V23.  Something good came from the added testing whether
> > the results are informative or not :)
> 
> Thanks!
> 
> I wonder why the results are affected even without any throttling settings but 
> just patched in? Specifically I'm talking about deadlines met with video 
> being sensitive to this. Were there any other config differences between the 
> tests? Changing HZ would invalidate the results for example. Comments?

I wondered the same.  The only difference then is the lower idle sleep
prio, tighter timeslice enforcement, and the SMP buglet fix for now <
p->timestamp due to SMP rounding.  Configs are identical.

	-Mike

