Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUFVM1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUFVM1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUFVM1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:27:14 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:43644 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263095AbUFVM1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:27:13 -0400
Date: Tue, 22 Jun 2004 07:27:57 -0500
From: Dean Nelson <dcn@sgi.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add wait_event_interruptible_exclusive() macro
Message-ID: <20040622122757.GA23606@sgi.com>
References: <40D30646.mailxA8X155I80@aqua.americas.sgi.com> <20040622120130.GA16246@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622120130.GA16246@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 05:01:30AM -0700, Chris Wedgwood wrote:
> On Fri, Jun 18, 2004 at 10:12:06AM -0500, Dean Nelson wrote:
> 
> > +#define __wait_event_interruptible_exclusive(wq, condition, ret)	\
> > +do {									\
> > +	wait_queue_t __wait;						\
> > +	init_waitqueue_entry(&__wait, current);				\
> > +									\
> > +	add_wait_queue_exclusive(&wq, &__wait);
> > \
> 
> [...]
> 
> Thsi reminds me...
> 
> I really loath all the preprocessor macros.  I know there are plenty
> of this already, but I don't see the advantage of macros over (static)
> inline functions which IMO look cleaner and give gcc some change to
> sanitize what it's looking at without actually having to have it used.
> 
> Is there a reason why we keep doing this?

In this particular case, I was just trying to 'conform' to what I found
in include/linux/wait.h.

If the community would prefer, I can resubmit my patch as an inline
function instead of a macro.

Dean
