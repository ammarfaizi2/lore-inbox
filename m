Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbUB0TMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUB0TJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:09:55 -0500
Received: from [66.35.79.110] ([66.35.79.110]:37766 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262934AbUB0TJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:09:33 -0500
Date: Fri, 27 Feb 2004 11:09:14 -0800
From: Tim Hockin <thockin@hockin.org>
To: Matt Mackall <mpm@selenic.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
Message-ID: <20040227190914.GA21737@hockin.org>
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com> <20040227185555.GJ3883@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227185555.GJ3883@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 12:55:55PM -0600, Matt Mackall wrote:
> Let's imagine you have n sources simultaneously interrupting on a
> given descriptor. Check the first, it's happening, acknowledge it,
> exit, notice interrupt still asserted, check the first, nope, check
> the second, yep, exit, etc. By the time we've made it to the nth ISR,
> we've banged on the first one n times, the second n-1 times, etc. In
> other words, early chain termination has an O(n^2) worst case.

That is a pretty pathological worst case, and n is (almost?) always small.
I don't know if it would make a lick of difference, or if it is worth the
risk. Someone who has a lot of shared interrupts ought to try it.
