Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTLVWAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTLVWAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:00:20 -0500
Received: from users.ccur.com ([208.248.32.211]:30835 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S264535AbTLVWAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:00:17 -0500
Date: Mon, 22 Dec 2003 16:59:34 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Rob Love <rml@ximian.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: atomic copy_from_user?
Message-ID: <20031222215933.GA3189@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <1072054100.1742.156.camel@cube> <20031222150026.GD27687@holomorphy.com> <20031222182637.GA2659@rudolph.ccur.com> <1072126506.3318.31.camel@fur> <20031222212237.GA2865@rudolph.ccur.com> <1072129210.3318.34.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072129210.3318.34.camel@fur>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 04:40:11PM -0500, Rob Love wrote:
> On Mon, 2003-12-22 at 16:22, Joe Korty wrote:
> 
> > I am guessing that nowdays even when preemption is disabled one can
> > find preempt_count still being used somewhere.  Otherwise it would be
> > better to replace all uses of inc_preempt_count() with
> > preempt_disable() and dec_preempt_count() with preempt_enable().
> 
> Right.  So why did you make this patch? :)
> 
> inc_preempt_count() and dec_preempt_count() are for use when you
> _absolutely_ must manage the preemption counter, regardless of whether
> or not kernel preemption is enabled.
> 
> They are used for things like atomic kmaps.

Hi Robert,
 I do not see why a non-preempt kernel would care at all about
the value of preempt_count.  (kmap_atomic is obviously setting it,
where is the place in a non-preempt kernel where the set value
is being acted upon?).

Joe

