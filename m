Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129296AbRBSVld>; Mon, 19 Feb 2001 16:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbRBSVlX>; Mon, 19 Feb 2001 16:41:23 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:38442 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129447AbRBSVlO>; Mon, 19 Feb 2001 16:41:14 -0500
Date: Mon, 19 Feb 2001 15:40:38 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Andrew Morton <andrewm@uow.edu.au>, David Woodhouse <dwmw2@infradead.org>,
        Kenn Humborg <kenn@linux.ie>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel_thread() & thread starting
In-Reply-To: <200102192117.f1JLHU518764@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1010219152412.32729D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Russell King wrote:
> Philipp Rumpf writes:
> > That still won't catch keventd oopsing though - which I think might happen
> > quite easily in real life.
> 
> Maybe we should panic in that case?  For example, what happens if kswapd
> oopses?  kreclaimd?  bdflush?  kupdate?  All these have the same problem,

No.  If kswapd oopses it's a bug in kswapd (or related code).  If keventd
oopses most likely the broken code is actually the task queue you
scheduled, which belongs to your driver.

