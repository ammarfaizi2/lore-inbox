Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268112AbUHXRRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268112AbUHXRRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268130AbUHXRRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 13:17:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:4239 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268112AbUHXRRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 13:17:39 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <412B4736.4040706@cybsft.com>
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu>
	 <20040823210151.GA10949@elte.hu> <1093312154.862.17.camel@krustophenia.net>
	 <20040824054128.GA29027@elte.hu> <1093326406.817.7.camel@krustophenia.net>
	 <412B4736.4040706@cybsft.com>
Content-Type: text/plain
Message-Id: <1093365170.817.27.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 13:17:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 09:48, K.R. Foley wrote:
> Lee Revell wrote:
> > On Tue, 2004-08-24 at 01:41, Ingo Molnar wrote:
> > 
> >>* Lee Revell <rlrevell@joe-job.com> wrote:
> >>
> >>
> >>>> - reduce netdev_max_backlog to 8 (Mark H Johnson)
> >>>
> >>>On my system this setting has absolutely no effect on the skb related
> >>>latencies. [...]
> >>
> >>it has an effect on input queue length. Output queue lengths can be
> >>reduced via 'ifconfig eth0 txqueuelen 8'.
> >>
> > 
> > 
> > OK.  With both of these set to 4, the largest latency I was able to
> > generate by ping flooding was 253 usecs.
> > 
> 
> Even with both of these set to 4, I still get similar results ~647 usec :(
> 

I am able to generate a 1012 usec latency by flood pinging the broadcast
address.  These are pretty pathological cases, but if we are going for
bounded latency it seems like they should be addressed.

Lee

