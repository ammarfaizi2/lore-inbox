Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUHXFqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUHXFqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266507AbUHXFqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:46:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13255 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266491AbUHXFqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:46:51 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040824054128.GA29027@elte.hu>
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu>
	 <20040823210151.GA10949@elte.hu> <1093312154.862.17.camel@krustophenia.net>
	 <20040824054128.GA29027@elte.hu>
Content-Type: text/plain
Message-Id: <1093326406.817.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 01:46:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 01:41, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > >  - reduce netdev_max_backlog to 8 (Mark H Johnson)
> > 
> > On my system this setting has absolutely no effect on the skb related
> > latencies. [...]
> 
> it has an effect on input queue length. Output queue lengths can be
> reduced via 'ifconfig eth0 txqueuelen 8'.
> 

OK.  With both of these set to 4, the largest latency I was able to
generate by ping flooding was 253 usecs.

Is there any particular reason one of these parameters is set via a
sysctl/proc entry, and one by ifconfig?

Lee

