Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWCWFx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWCWFx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWCWFx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:53:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:55507 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750782AbWCWFx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:53:28 -0500
X-Authenticated: #14349625
Subject: Re: [interbench numbers] Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <willy@w.ods.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com, Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200603231643.36093.kernel@kolivas.org>
References: <1142592375.7895.43.camel@homer>
	 <200603230727.51235.kernel@kolivas.org> <1143084178.7665.6.camel@homer>
	 <200603231643.36093.kernel@kolivas.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 06:53:49 +0100
Message-Id: <1143093229.9303.1.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 16:43 +1100, Con Kolivas wrote:
> On Thu, 23 Mar 2006 02:22 pm, Mike Galbraith wrote:
> > On Thu, 2006-03-23 at 07:27 +1100, Con Kolivas wrote:
> > > I wonder why the results are affected even without any throttling
> > > settings but just patched in? Specifically I'm talking about deadlines
> > > met with video being sensitive to this. Were there any other config
> > > differences between the tests? Changing HZ would invalidate the results
> > > for example. Comments?
> >
> > I wondered the same.  The only difference then is the lower idle sleep
> > prio, tighter timeslice enforcement, and the SMP buglet fix for now <
> > p->timestamp due to SMP rounding.  Configs are identical.
> 
> Ok well if we're going to run with this set of changes then we need to assess 
> the affect of each change and splitting them up into separate patches would 
> be appropriate normally anyway. That will allow us to track down which 
> particular patch causes it. That won't mean we will turn down the change 
> based on that one result, though, it will just help us understand it better.

I'm investigating now.

	-Mike

