Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbRBSVYK>; Mon, 19 Feb 2001 16:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBSVYA>; Mon, 19 Feb 2001 16:24:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32527 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129721AbRBSVXu>;
	Mon, 19 Feb 2001 16:23:50 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102192117.f1JLHU518764@flint.arm.linux.org.uk>
Subject: Re: kernel_thread() & thread starting
To: prumpf@mandrakesoft.com (Philipp Rumpf)
Date: Mon, 19 Feb 2001 21:17:30 +0000 (GMT)
Cc: andrewm@uow.edu.au (Andrew Morton), dwmw2@infradead.org (David Woodhouse),
        kenn@linux.ie (Kenn Humborg),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <Pine.LNX.3.96.1010219073717.16489K-100000@mandrakesoft.mandrakesoft.com> from "Philipp Rumpf" at Feb 19, 2001 07:50:54 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Rumpf writes:
> That still won't catch keventd oopsing though - which I think might happen
> quite easily in real life.

Maybe we should panic in that case?  For example, what happens if kswapd
oopses?  kreclaimd?  bdflush?  kupdate?  All these have the same problem,
and should probably have the same "fix" applied, whatever that fix may
be.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

