Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132704AbRDCXW6>; Tue, 3 Apr 2001 19:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132715AbRDCXWs>; Tue, 3 Apr 2001 19:22:48 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:41968
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S132704AbRDCXWj>; Tue, 3 Apr 2001 19:22:39 -0400
Date: Tue, 3 Apr 2001 16:18:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.3 and SysRq over serial console
Message-ID: <20010403161801.A7656@opus.bloom.county>
In-Reply-To: <20010331163808.A9740@opus.bloom.county> <20010403210744.A22460@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010403210744.A22460@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Apr 03, 2001 at 09:07:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 09:07:44PM +0100, Russell King wrote:
> On Sat, Mar 31, 2001 at 04:38:08PM -0700, Tom Rini wrote:
> > Hello all.  Without the attached patch, SysRq doesn't work over a serial
> > console here.  Has anyone else seen this problem?
> 
> It is handled at the serial port driver level, not the tty level.  You need
> to turn on CONFIG_SERIAL_CONSOLE and CONFIG_MAGIC_SYSRQ, and issue a break
> followed by the relevent character within 5 seconds on the serial TTY being
> used as the kernel console.

After talking with the person who originally did the patch, yeah, that does
make sense (and the serial driver we're using needs to be fixed).  Thanks.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
