Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266670AbUGKXL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbUGKXL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 19:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266671AbUGKXL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 19:11:28 -0400
Received: from peabody.ximian.com ([130.57.169.10]:34720 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266670AbUGKXLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 19:11:11 -0400
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
From: Robert Love <rml@ximian.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjanv@redhat.com, linux-audio-dev@music.columbia.edu
In-Reply-To: <20040711103020.GA24797@elte.hu>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org> <20040711093209.GA17095@elte.hu>
	 <20040711024518.7fd508e0.akpm@osdl.org> <20040711095039.GA22391@elte.hu>
	 <20040711025855.08afbca1.akpm@osdl.org>  <20040711103020.GA24797@elte.hu>
Content-Type: text/plain
Date: Sun, 11 Jul 2004 19:12:23 -0400
Message-Id: <1089587543.3619.9.camel@lucy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-11 at 12:30 +0200, Ingo Molnar wrote:

> the reason is difference in overhead (codesize, speed) and risks (driver
> robustness). We do not want to enable preempt for Fedora yet because it
> breaks just too much stuff and is too heavy. So we looked for a solution
> that might work for a generic distro.

I think we should work toward being able to enable kernel preemption in
Fedora, then, instead of other tangential solutions.

And I disagree with the overhead argument.  I have seen no specific
arguments that show a significant overhead.  Heck, when people tried to
show that kernel preemption hurt throughput, we saw tests that showed
improved throughput (probably due to better utilization of I/O).

But stability is a subjective argument (and I agree we need more driver
love, at least for obscure drivers) wrt kernel preemption.  So I would
say we should concentrate on working on the stability[1] so we could
just enable kernel preemption unconditionally and not designing new
solutions.

Best,

	Robert Love

[1] What better way than enabling CONFIG_PREEMPT for Fedora?  Enable it
for Fedora, and do not enable it for Red Hat Enterprise until you are
confidant.  ;-)


