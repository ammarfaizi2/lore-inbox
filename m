Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWHXJFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWHXJFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 05:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWHXJFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 05:05:04 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:45067 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750956AbWHXJFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 05:05:03 -0400
Date: Thu, 24 Aug 2006 10:04:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [HELP] Power management for embedded system
Message-ID: <20060824090455.GA18202@flint.arm.linux.org.uk>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
References: <20060824084425.83538.qmail@web25802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824084425.83538.qmail@web25802.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 08:44:25AM +0000, moreau francis wrote:
> Mips one seems to be a copy and paste of arm one and both of them
> have removed all APM bios stuff orginally part of i386 implementation.

The BIOS stuff makes no sense on ARM - there isn't a BIOS to do anything
with.

> It doesn't seem that APM is something really stable and finished.

It's complete.  It's purpose is to provide the interface to userland so
that programs know about suspend/resume events, and can initiate suspends.
Eg, the X server.

The power management really comes from the Linux drivers themselves,
which are written to peripherals off when they're not in use.  The other
power saving comes from things like cpufreq - again, nothing to do with
the magical "APM" or "ACPI" terms.

On embedded platforms, you shouldn't think about power management in
terms of the non-embedded PM technologies.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
