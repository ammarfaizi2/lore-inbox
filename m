Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWH1Wlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWH1Wlj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWH1Wli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:41:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:5866 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964872AbWH1Wli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:41:38 -0400
Subject: Re: Linux time code
From: john stultz <johnstul@us.ibm.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, theotso@us.ibm.com, zippel@linux-m68k.org
In-Reply-To: <20060826001748.5089.qmail@science.horizon.com>
References: <20060826001748.5089.qmail@science.horizon.com>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 15:41:35 -0700
Message-Id: <1156804896.16398.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 20:17 -0400, linux@horizon.com wrote:
> > Overall, I like your idea quite a bit. Might we look forward to a
> > patch? :)
> 
> Researching this has led me into that pit of madness, the i8254
> programmable interval timer specification.
> 
> This is the original IBM PC timer (well, the version after the original
> 8253), counting at 13125000/11 = 1193181.81... Hz, programmed to divide
> by 11932 to generate a 100 Hz timer interrupt.  If you want to be picky,
> the options are

With the new clocksource code, we can (currently just i386, but the
architecture is generic and I'm working on the other arches) make use of
continuous clocksources for accumulating time instead of having the deal
with the problematic PIT (as well as the lost ticks issue).

Maybe I'm missing what you're proposing, but I think "that pit of
madness" can now be avoided. :)

thanks
-john



