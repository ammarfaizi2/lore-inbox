Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWEZVl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWEZVl0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWEZVl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:41:26 -0400
Received: from waste.org ([64.81.244.121]:46043 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751632AbWEZVlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:41:25 -0400
Date: Fri, 26 May 2006 16:33:43 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: APM suspend to RAM broken, culprit found
Message-ID: <20060526213343.GQ24227@waste.org>
References: <20060526211249.GP24227@waste.org> <20060526143353.42a456fe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526143353.42a456fe.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 02:33:53PM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > Bisection reveals that the patch entitled:
> > 
> > [PATCH] swsusp: add check for suspension of X-controlled devices
> > 
> > breaks resume of ipw2200, synaptics mouse, USB, and probably other
> > useful bits on my Thinkpad R51. Notably, I'm using APM.
> > 
> 
> Would that be because APM remains in X while suspending, but swsusp flicks
> back to VT mode?

Probably something like that.

I believe the patch description is a bit misleading as well. Obviously
my wireless adapter is not "X-controlled".
 
> Anyway, I'll queue a revert patch for 2.6.17, thanks.

For the record, I've booted tip patched with this code disabled and
everything's happy again.

-- 
Mathematics is the supreme nostalgia of our time.
