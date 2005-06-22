Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVFVSv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVFVSv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVFVSv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:51:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:49102 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261867AbVFVStv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:49:51 -0400
Date: Wed, 22 Jun 2005 11:50:19 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622185019.GG1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119460803.5825.13.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 01:20:03PM -0400, Kristian Benoit wrote:
> On Wed, 2005-06-22 at 09:27 -0700, Paul E. McKenney wrote:
> > On Wed, Jun 22, 2005 at 11:31:39AM -0400, Karim Yaghmour wrote:
> > 
> > If I understand your analysis correctly (hah!!!), your breakdown
> > of the maximum delay assumes that the maximum delays for the logger
> > and the target are correlated.  What causes this correlation?
> > My (probably hopelessly naive) assumption would be that there would
> > be no such correlation.  In absence of correlation, one might
> > approximate the maximum ipipe delay by subtracting the -average-
> > ipipe delay from the maximum preemption delay, for 55us - 7us = 48us.
> > Is this the case, or am I missing something here?
> 
> Your analysis is correct, but with 600,000 samples, it is possible that
> we got 2 peeks (perhaps not maximum), one on the logger and one on the
> target. So in my point of view, the maximum value is probably somewhere
> between 55us / 2 and 55us - 7us. And probably closer to 55us / 2.

Possible, but it could also be a large peak and a small one.

Any way of getting the logger's latency separately?  Or the target's?

						Thanx, Paul
