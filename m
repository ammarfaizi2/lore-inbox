Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbUDAGBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 01:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUDAGBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 01:01:17 -0500
Received: from [194.67.69.111] ([194.67.69.111]:34955 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S262651AbUDAGBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 01:01:14 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200404010600.KAA08004@yakov.inr.ac.ru>
Subject: Re: route cache DoS testing and softirqs
To: dipankar@in.ibm.com
Date: Thu, 1 Apr 2004 10:00:36 +0400 (MSD)
Cc: andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Robert.Olsson@data.slu.se,
       paulmck@us.ibm.com (Paul E. McKenney), davem@redhat.com (Dave Miller),
       akpm@osdl.org (Andrew Morton)
In-Reply-To: <20040330202820.GA3956@in.ibm.com> from "Dipankar Sarma" at Mar 31, 2004 01:58:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > We had one full solution for this issue not changing anything
> > in scheduler/softirq relationship: to run rcu task for the things
> > sort of dst cache not from process context, but essentially as part
> > of do_softirq(). Simple, stupid and apparently solves new problems
> > which rcu created.
> 
> Can you be a little bit more specific about this solution ?

It is about that your suggestion, which you outlined below :-)

> as indicated by my earlier experiments. We have potential fixes
> for RCU through a call_rcu_bh() interface where completion of a
> softirq handler is a quiescent state. I am working on forward porting
> that old patch from our discussion last year and testing in my
> environment. That should increase the number of quiescent state
> points significantly and hopefully reduce the grace period significantly.
> But this does nothing to help userland starvation.

Alexey
