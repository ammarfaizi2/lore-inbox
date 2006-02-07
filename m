Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWBGRnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWBGRnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWBGRnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:43:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15888 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932263AbWBGRnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:43:19 -0500
Date: Tue, 7 Feb 2006 17:43:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Glen Turner <glen.turner@aarnet.edu.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060207174307.GA26558@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Glen Turner <glen.turner@aarnet.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Kumar Gala <galak@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <20060206202654.GC2470@ucw.cz> <20060206205459.GB9388@flint.arm.linux.org.uk> <20060207091804.GA1840@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207091804.GA1840@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 10:18:04AM +0100, Pavel Machek wrote:
> I'm afraid that auditing kernel to never ever print \n from user will
> be quite a long job. If I get
> 
> Killed process 1234
> System Halted
> due to OOM
> 
> I am going to figure it out no problem, but modems do not have that
> kind of abilities...

In that case the problem is unsolvable.  What if I named a process

\n+++ATH0\n

?  Oh dear, your modem just hung up.  Or maybe:

\n+++AT&C0\n

and now your modem always sets DCD active, so even with detection of DCD
in the kernel, I can now talk to it via process names after I've forced
it to disconnect.

And yes, there's modems out there which accept that and act on the '+++'
immediately - no pause after '+++' required.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
