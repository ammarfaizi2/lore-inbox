Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbVKUQoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbVKUQoD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVKUQoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:44:03 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34583
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751026AbVKUQoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:44:02 -0500
Date: Mon, 21 Nov 2005 17:43:49 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: disable tsc with seccomp
Message-ID: <20051121164349.GE14746@opteron.random>
References: <20051105134727.GF18861@opteron.random> <200511051712.09280.ak@suse.de> <20051105163134.GC14064@opteron.random> <200511051804.08306.ak@suse.de> <20051106015542.GE14064@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106015542.GE14064@opteron.random>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there was no feedback to my last post, I assume you agree, so
please backout the tsc disable so then I can plug the performane counter
disable on top of it (at zero additional runtime cost).

Also note: even if it may not be obvious because it's nicely hidden by
header files, if you disable CONFIG_SECCOMP, the tsc disable patch
becomes a noop and it's optimized away by gcc (like the rest of
seccomp).

So if you don't want to risk the microslowdown in your systems, just
disable SECCOMP and be done with it but please resurrect that patch so I
can fix the performance counters too after that.

Thanks!
