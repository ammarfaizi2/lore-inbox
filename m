Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264724AbUD1K2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264724AbUD1K2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUD1K2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:28:32 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:58641 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S264724AbUD1K20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:28:26 -0400
Date: Wed, 28 Apr 2004 12:28:27 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Christoph Pohl <christoph.pohl@inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Low bogomips on IBM x445 (kernel 2.6.5)
Message-ID: <20040428102827.GB14817@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <408E3D74.2090301@inf.tu-dresden.de> <20040427180117.GA2150@middle.of.nowhere> <408F4632.2090705@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408F4632.2090705@inf.tu-dresden.de>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Pohl <christoph.pohl@inf.tu-dresden.de>
Date: Wed, Apr 28, 2004 at 07:50:42AM +0200
> >cat /proc/mtrr
> 
> reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
> reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
> reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
> reg03: base=0xe0000000 (3584MB), size= 256MB: write-back, count=1
> reg04: base=0x100000000 (4096MB), size=4096MB: write-back, count=1
> reg05: base=0x200000000 (8192MB), size=8192MB: write-back, count=1
> memory:
> 8192MB (8GB), plus 2GB swap space.
> Does memory size somehow affect bogomips calculation?
> 
> There are however some noteworthy lines in syslog during reboot:
> (...)
> Apr 26 14:25:40 x445 kernel: Using local APIC timer interrupts.
> Apr 26 14:25:40 x445 kernel: calibrating APIC timer ...
> Apr 26 14:25:40 x445 kernel: ..... CPU clock speed is 2993.0654 MHz.
> Apr 26 14:25:40 x445 kernel: ..... host bus clock speed is 99.0788 MHz.
> Apr 26 14:25:40 x445 kernel: checking TSC synchronization across 8 CPUs:
> Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#0 improperly initialized, has 
> 7358270 usecs TSC skew! FIXED.
> Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#1 improperly initialized, has 
> 7358270 usecs TSC skew! FIXED.
> Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#2 improperly initialized, has 
> -7358271 usecs TSC skew! FIXED.
> Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#3 improperly initialized, has 
> -7358271 usecs TSC skew! FIXED.
> Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#4 improperly initialized, has 
> 7358271 usecs TSC skew! FIXED.
> Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#5 improperly initialized, has 
> 7358270 usecs TSC skew! FIXED.
> Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#6 improperly initialized, has 
> -7358269 usecs TSC skew! FIXED.
> Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#7 improperly initialized, has 
> -7358271 usecs TSC skew! FIXED.
> Apr 26 14:25:40 x445 kernel: Brought up 8 CPUs
> (...)
> 
> I don't know if that's any help.

I recall some earlier messages where some crucial part of memory was
marked 'non-cacheable' in /proc/mtrr, and linux ran very slow. But on
re-reading, your problem is more that linux isn't slow, but bogomips
(and only bogomips) don't seem right?


In that case, you may need the help of a real kernel hacker, not a
piddling amateur like me :-)

Good luck,
Jurriaan
-- 
Nothing is a waste of time if you use the experience wisely.
        Rodin
Debian (Unstable) GNU/Linux 2.6.6-rc2-mm2 2x6062 bogomips 0.07 0.02
