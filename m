Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWHSHfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWHSHfl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 03:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWHSHfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 03:35:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25572 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932459AbWHSHfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 03:35:39 -0400
Date: Sat, 19 Aug 2006 00:28:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: Network receive stall avoidance (was [PATCH 2/9] deadlock
 prevention core)
Message-Id: <20060819002848.e6884792.akpm@osdl.org>
In-Reply-To: <44E69011.4080604@google.com>
References: <20060808211731.GR14627@postel.suug.ch>
	<44DBED4C.6040604@redhat.com>
	<44DFA225.1020508@google.com>
	<20060813.165540.56347790.davem@davemloft.net>
	<44DFD262.5060106@google.com>
	<20060813185309.928472f9.akpm@osdl.org>
	<1155530453.5696.98.camel@twins>
	<20060813215853.0ed0e973.akpm@osdl.org>
	<44E3E964.8010602@google.com>
	<20060816225726.3622cab1.akpm@osdl.org>
	<44E5015D.80606@google.com>
	<20060817230556.7d16498e.akpm@osdl.org>
	<44E62F7F.7010901@google.com>
	<20060818153455.2a3f2bcb.akpm@osdl.org>
	<44E650C1.80608@google.com>
	<20060818194435.25bacee0.akpm@osdl.org>
	<44E69011.4080604@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 21:14:09 -0700
Daniel Phillips <phillips@google.com> wrote:

> So rather than just the word deadlock, let us add "or atomic 0 order
> alloc failure during TCP receive" to the challenge.  Fair?

If it's significantly performance-affecting in any way which is at all likely to 
affect anyone, sure.

You can get those warnings now with regular networking using e1000, due to
a combination of excessive default rx ringsize and incorrect VM tuning.
