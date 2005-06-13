Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFMClo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFMClo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 22:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVFMClo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 22:41:44 -0400
Received: from opersys.com ([64.40.108.71]:11271 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261326AbVFMCll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 22:41:41 -0400
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: Kristian Benoit <kbenoit@opersys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: James R Bruce <bruce@andrew.cmu.edu>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, pmarques@grupopie.com,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <20050612145401.GB15864@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu>
	 <42AAF5CE.9080607@opersys.com> <20050611145240.GA10881@elte.hu>
	 <42AB2209.9080006@opersys.com> <20050611181528.GA15019@elte.hu>
	 <38010.210.137.194.5.1118573221.squirrel@210.137.194.5>
	 <20050612145401.GB15864@elte.hu>
Content-Type: text/plain
Date: Sun, 12 Jun 2005 22:39:25 -0400
Message-Id: <1118630365.5787.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 16:54 +0200, Ingo Molnar wrote:
> * James R Bruce <bruce@andrew.cmu.edu> wrote:
> 
> > Ingo, if you could document the right options required for decent 
> > performace somewhere it would be quite helpful (maybe in 
> > Documentation/rt-preempt?).  My first test of Preempt-RT showed 
> > unexpectedly high overhead for a fairly benign network load (120 UDP 
> > packets/sec), but that was likely the result of leaving some debugging 
> > options on.
> 
> agreed, this needs to be addressed.
> 
> in the latest patch (-48-17 or later) i have changed the debugging 
> options to default to off. (this wont turn them off if your .config has 
> them turned on already, but will turn them off for new testers' 
> .configs)
> 
> I also added a prominent boot-time message that, if certain 
> high-overhead debugging options are enabled, says:
> 
> *****************************************************************************
> *                                                                           *
> * WARNING, the following debugging options are turned on in your .config:   *
> *                                                                           *
> *        CONFIG_DEBUG_RT_LOCKING_MODE                                       *
> *        CONFIG_RT_DEADLOCK_DETECT                                          *
> *        CONFIG_DEBUG_PREEMPT                                               *
> *        CONFIG_CRITICAL_PREEMPT_TIMING                                     *
> *        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *
> *        CONFIG_LATENCY_TRACE                                               *
> *        CONFIG_DEBUG_SLAB                                                  *
> *                                                                           *
> * they may increase runtime overhead and latencies considerably!            *
> *                                                                           *
> *****************************************************************************
> 
> wrt. documentation - i'm not a big doc writer, but i'm taking patches
> :-)
> 
> 	Ingo

Thanks, that will help us getting better results from PREEMPT_RT.

Kristian

