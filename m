Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUGNVQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUGNVQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUGNVQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:16:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37847 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265773AbUGNVPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:15:52 -0400
Subject: Re: gettimeofday nanoseconds patch (makes it possible for the
	posix-timer functions to return higher accuracy)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, ia64 <linux-ia64@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407141323530.15874@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0407140940260.14704@schroedinger.engr.sgi.com>
	 <1089835776.1388.216.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0407141323530.15874@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1089839740.1388.230.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Jul 2004 14:15:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 13:28, Christoph Lameter wrote:
> > None the less, I do understand the desire for the change (and am working
> > to address it in 2.7), so could you at least use a better name then
> > gettimeofday()? Maybe get_ns_time() or something? Its just too similar
> > to do_gettimeofday and the syscall gettimeofday().
> 
> Right. I had it named getnstimeofday before but the feeling was that the
> patch should not introduce a new name. Any approach that would allow
> progress on the issue would be fine with me.

Fair enough. getnstimeofday() sounds good enough for me. 

> > Really, I feel the cleaner method is to fix do_gettimeofday() so it
> > returns a timespec and then convert it to a timeval in
> > sys_gettimeofday(). However this would add overhead to the syscall, so I
> > doubt folks would go for it.
> 
> do_gettimeofday is used all over the linux kernel for a variety of
> purposes and lots of code depends on the presence of a timeval struct.

Indeed, it would be a decent amount of work to clean that up as well.

thanks
-john

