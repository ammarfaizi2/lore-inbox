Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVBGLoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVBGLoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 06:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVBGLoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 06:44:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28943 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261252AbVBGLoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 06:44:04 -0500
Date: Mon, 7 Feb 2005 11:43:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050207114359.A32277@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050124154326.A5541@flint.arm.linux.org.uk> <20050131161753.GA15674@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050131161753.GA15674@mars.ravnborg.org>; from sam@ravnborg.org on Mon, Jan 31, 2005 at 05:17:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 05:17:53PM +0100, Sam Ravnborg wrote:
> On Mon, Jan 24, 2005 at 03:43:26PM +0000, Russell King wrote:
> > Sam,
> > 
> > Where did the hacks go which detect the silent failure of the ARM binutils?
> 
> They weant away because it caused lots of troubles with sparc and um.
> Can you use this (untested patch) for arm?

After fixing the obvious problems with this patch, it leaves one remaining.
make vmlinux doesn't invoke this check, and people actually use vmlinux
in the embedded world (even though some of us would prefer them not to.)

Maybe we need an architecture hook or something for post-processing
vmlinux?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
