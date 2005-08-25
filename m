Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVHYBtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVHYBtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVHYBtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:49:05 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27641 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932477AbVHYBtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:49:04 -0400
Date: Wed, 24 Aug 2005 21:48:34 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Daniel Walker <dwalker@mvista.com>
cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
In-Reply-To: <1124933925.17712.31.camel@dhcp153.mvista.com>
Message-ID: <Pine.LNX.4.58.0508242143420.13845@localhost.localdomain>
References: <1124295214.5764.163.camel@localhost.localdomain> 
 <20050817162324.GA24495@elte.hu>  <1124323379.5186.18.camel@localhost.localdomain>
  <1124333050.5186.24.camel@localhost.localdomain>  <20050822075012.GB19386@elte.hu>
  <1124704837.5208.22.camel@localhost.localdomain>  <20050822101632.GA28803@elte.hu>
  <1124710309.5208.30.camel@localhost.localdomain>  <20050822113858.GA1160@elte.hu>
  <1124715755.5647.4.camel@localhost.localdomain>  <20050822183355.GB13888@elte.hu>
  <1124739657.5809.6.camel@localhost.localdomain>  <1124739895.5809.11.camel@localhost.localdomain>
  <1124749192.17515.16.camel@dhcp153.mvista.com>  <1124756775.5350.14.camel@localhost.localdomain>
  <1124758291.9158.17.camel@dhcp153.mvista.com>  <1124760725.5350.47.camel@localhost.localdomain>
  <1124768282.5350.69.camel@localhost.localdomain> 
 <1124908080.5604.22.camel@localhost.localdomain>  <1124917003.5711.8.camel@localhost.localdomain>
  <1124932391.5527.15.camel@localhost.localdomain> <1124933925.17712.31.camel@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Aug 2005, Daniel Walker wrote:

>
> I got a report of a possible softlockup with setiathome, the trace
> wasn't a little garbled though . I'm not sure the checking is working
> correctly . But if it is maybe these spot need some performance
> analysis . Didn't you changes catch anything that stays in the kernel
> for 10 seconds or more ?
>

I haven't looked that hard yet.  If Ingo is ready for my changes, to
replace the pi_lock, then I can spend time tracking this down.

Something is definity wrong, regardless whether or not the output is
right.  The tests constantly spit crap out, but when this happens,
everything is silent.  So something is definity amiss.

Try it out and see what I mean.

-- Steve
