Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269297AbUIYJ44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269297AbUIYJ44 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 05:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUIYJ44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 05:56:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36617 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269297AbUIYJ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 05:56:54 -0400
Date: Sat, 25 Sep 2004 10:56:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: jonathan@jonmasters.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Add wait_event_timeout()
Message-ID: <20040925105649.B29796@flint.arm.linux.org.uk>
Mail-Followup-To: jonathan@jonmasters.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20040925091359.GA4431@dyn-67.arm.linux.org.uk> <35fb2e590409250242dd353d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <35fb2e590409250242dd353d9@mail.gmail.com>; from jonmasters@gmail.com on Sat, Sep 25, 2004 at 10:42:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 10:42:15AM +0100, Jon Masters wrote:
> On Sat, 25 Sep 2004 10:13:59 +0100, Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > There appears to be one case missing from the wait_event() family -
> > the uninterruptible timeout wait.  The following patch adds this.
> 
> 
> Any reason it's called wait_event_timeout then rather than
> wait_event_uninterruptible_timeout?

Because I chose to follow the existing naming scheme.

wait_event() - uninterruptible wait
wait_event_interruptible() - interruptible wait
wait_event_interruptible_timeout() - interruptible wait with timeout

so, the uninterruptible wait with timeout can only logically be:

wait_event_timeout()

Lets not go starting a new naming scheme. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
