Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRDCUI5>; Tue, 3 Apr 2001 16:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132664AbRDCUIr>; Tue, 3 Apr 2001 16:08:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11794 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132655AbRDCUIf>;
	Tue, 3 Apr 2001 16:08:35 -0400
Date: Tue, 3 Apr 2001 21:07:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.3 and SysRq over serial console
Message-ID: <20010403210744.A22460@flint.arm.linux.org.uk>
In-Reply-To: <20010331163808.A9740@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010331163808.A9740@opus.bloom.county>; from trini@kernel.crashing.org on Sat, Mar 31, 2001 at 04:38:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2001 at 04:38:08PM -0700, Tom Rini wrote:
> Hello all.  Without the attached patch, SysRq doesn't work over a serial
> console here.  Has anyone else seen this problem?

It is handled at the serial port driver level, not the tty level.  You need
to turn on CONFIG_SERIAL_CONSOLE and CONFIG_MAGIC_SYSRQ, and issue a break
followed by the relevent character within 5 seconds on the serial TTY being
used as the kernel console.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

