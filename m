Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWCWFnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWCWFnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWCWFnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:43:04 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:53710 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932226AbWCWFnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:43:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [interbench numbers] Re: interactive task starvation
Date: Thu, 23 Mar 2006 16:43:35 +1100
User-Agent: KMail/1.8.3
Cc: lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <willy@w.ods.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com, Peter Williams <pwil3058@bigpond.net.au>
References: <1142592375.7895.43.camel@homer> <200603230727.51235.kernel@kolivas.org> <1143084178.7665.6.camel@homer>
In-Reply-To: <1143084178.7665.6.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231643.36093.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2006 02:22 pm, Mike Galbraith wrote:
> On Thu, 2006-03-23 at 07:27 +1100, Con Kolivas wrote:
> > I wonder why the results are affected even without any throttling
> > settings but just patched in? Specifically I'm talking about deadlines
> > met with video being sensitive to this. Were there any other config
> > differences between the tests? Changing HZ would invalidate the results
> > for example. Comments?
>
> I wondered the same.  The only difference then is the lower idle sleep
> prio, tighter timeslice enforcement, and the SMP buglet fix for now <
> p->timestamp due to SMP rounding.  Configs are identical.

Ok well if we're going to run with this set of changes then we need to assess 
the affect of each change and splitting them up into separate patches would 
be appropriate normally anyway. That will allow us to track down which 
particular patch causes it. That won't mean we will turn down the change 
based on that one result, though, it will just help us understand it better.

Cheers,
Con
