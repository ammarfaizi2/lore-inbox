Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269334AbTGJP17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269353AbTGJP17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:27:59 -0400
Received: from are.twiddle.net ([64.81.246.98]:34488 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S269334AbTGJP0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:26:16 -0400
Date: Thu, 10 Jul 2003 08:40:19 -0700
From: Richard Henderson <rth@twiddle.net>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@digeo.com>,
       Ian Molton <spyro@f2s.com>
Subject: Re: [PATCH] Fix do_div() for all architectures
Message-ID: <20030710154019.GA18697@twiddle.net>
Mail-Followup-To: Bernardo Innocenti <bernie@develer.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Andrea Arcangeli <andrea@suse.de>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Andrew Morton <akpm@digeo.com>, Ian Molton <spyro@f2s.com>
References: <200307060133.15312.bernie@develer.com> <200307070626.08215.bernie@develer.com> <200307082027.26233.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307082027.26233.bernie@develer.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 08:27:26PM +0200, Bernardo Innocenti wrote:
> +extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor)
> __attribute_pure__;
...
> +		__rem = __div64_32(&(n), __base);	\

The pure declaration is very incorrect.  You're writing to N.


r~
