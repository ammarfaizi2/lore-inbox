Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVEOODn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVEOODn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 10:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVEOODm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 10:03:42 -0400
Received: from colin.muc.de ([193.149.48.1]:33550 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261636AbVEOODa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 10:03:30 -0400
Date: 15 May 2005 16:03:26 +0200
Date: Sun, 15 May 2005 16:03:26 +0200
From: Andi Kleen <ak@muc.de>
To: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
Message-ID: <20050515140326.GA94354@muc.de>
References: <20050513184806.GA24166@redhat.com> <m1u0l4afdx.fsf@muc.de> <20050515130742.A29619@flint.arm.linux.org.uk> <m1ekc8adfl.fsf@muc.de> <20050515150103.B29619@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050515150103.B29619@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 03:01:03PM +0100, Russell King wrote:
> On Sun, May 15, 2005 at 02:20:14PM +0200, Andi Kleen wrote:
> > Then someone needs to convince Linus to export touch_nmi_watchdog
> > again. 
> > 
> > Or how about checking if interrupts are off here (iirc we have 
> > a generic function for that now) and then using
> > a smaller timeout and otherwise schedule_timeout() ?
> 
> The interrupt state doesn't tell us whether we can schedule.  It
> tells us when we can't schedule, which is different from when we
> can.  For example:

Yes, you're right of course.  Must have not been thinking clearly.

-Andi
