Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUIWRxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUIWRxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268191AbUIWRxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:53:42 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:13246 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268203AbUIWRwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:52:08 -0400
Subject: Re: __attribute__((always_inline)) fiasco
From: Albert Cahalan <albert@users.sf.net>
To: Richard Henderson <rth@twiddle.net>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040923165406.GB11968@twiddle.net>
References: <1095956778.4966.940.camel@cube>
	 <20040923165406.GB11968@twiddle.net>
Content-Type: text/plain
Organization: 
Message-Id: <1095961600.4973.958.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Sep 2004 13:46:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 12:54, Richard Henderson wrote:
> On Thu, Sep 23, 2004 at 12:26:18PM -0400, Albert Cahalan wrote:
> > Are benchmarks significantly affected if you remove the inline?
> 
> The routines in question expand to exactly one instruction.

Fine, but that's not what I asked.

I asked if it shows up on benchmarks. It doesn't, does it?

Supposing that it does, then you might use the
alternate instruction replacement trick for this.
That will beat function pointers for speed.

Also, a simple conditional branch might be better
predicted than a function pointer anyway. At least
it will be close.

So you have at least four reasonable choices:

a. don't inline at all
b. have an uninline_foo() version for each foo
c. instruction replacement
d. simple conditional

The simple choices are better, unless you have
benchmarks (whole system ones) that show otherwise.


