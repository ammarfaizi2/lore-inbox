Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTLVWGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbTLVWGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:06:53 -0500
Received: from users.ccur.com ([208.248.32.211]:14470 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S264498AbTLVWGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:06:52 -0500
Date: Mon, 22 Dec 2003 17:06:11 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Rob Love <rml@ximian.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: atomic copy_from_user?
Message-ID: <20031222220610.GA3451@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <1072054100.1742.156.camel@cube> <20031222150026.GD27687@holomorphy.com> <20031222182637.GA2659@rudolph.ccur.com> <1072126506.3318.31.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072126506.3318.31.camel@fur>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 03:55:06PM -0500, Rob Love wrote:
> On Mon, 2003-12-22 at 13:26, Joe Korty wrote:
> 
> > Shouldn't the dec_prempt_count() in kunmap_atomic() be followed
> > by a preempt_check_resched()???
> 
> Probably.
> 
> Actually, dec_preempt_count() ought to call preempt_check_resched()
> itself.  In the case of !CONFIG_PREEMPT, that call would simply optimize
> away.
> 
> Attached patch is against 2.6.0.

If this is done then preempt_enable_no_resched() and preempt_enable() also
need to be adjusted, as they both call dec_preempt_count().

Joe
