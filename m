Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWHBVit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWHBVit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWHBVit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:38:49 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:31758 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932232AbWHBVis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:38:48 -0400
Date: Wed, 2 Aug 2006 22:38:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: Linux v2.6.18-rc3
Message-ID: <20060802213834.GB17599@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Dave Jones <davej@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Jesse Brandeburg <jesse.brandeburg@gmail.com>,
	Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
	linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
References: <20060731081112.05427677.akpm@osdl.org> <20060801215919.8596da9d.akpm@osdl.org> <4807377b0608021257p27882866i69a5a0a4a1f05dda@mail.gmail.com> <200608022216.54797.rjw@sisk.pl> <20060802202309.GD7173@flint.arm.linux.org.uk> <20060802203236.GC23389@redhat.com> <20060802205824.GA17599@flint.arm.linux.org.uk> <Pine.LNX.4.64.0608021416200.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608021416200.4168@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 02:18:55PM -0700, Linus Torvalds wrote:
> Well, more importantly, why would we do something like this in the first 
> place?

The low level drivers can do that already if they so wish.  We provide
a library function to allow them to do the generic parts, which is
what we're talking about here.

> The serial layer should use set_termios() when users set the termios state 
> (surprise surprise), not to emulate suspend/restore.

Yes Linus, you're obviously right.  Would you mind re-engineering this
while I'm away for the next few days.  For _ALL_ serial drivers, not
just 8250.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
