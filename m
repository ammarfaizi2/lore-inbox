Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281517AbRKHLXE>; Thu, 8 Nov 2001 06:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281516AbRKHLWy>; Thu, 8 Nov 2001 06:22:54 -0500
Received: from [212.18.232.186] ([212.18.232.186]:43018 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S281518AbRKHLWl>; Thu, 8 Nov 2001 06:22:41 -0500
Date: Thu, 8 Nov 2001 11:22:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspected error in make dep
Message-ID: <20011108112225.A2642@flint.arm.linux.org.uk>
In-Reply-To: <3BEA599B.6080606@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEA599B.6080606@wipro.com>; from balbir.singh@wipro.com on Thu, Nov 08, 2001 at 03:38:27PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 03:38:27PM +0530, BALBIR SINGH wrote:
> sa1100fb.c:164:27: linux/cpufreq.h: No such file or directory

linux/cpufreq.h is a generic framework for controlling the CPU clock speed
(and therefore the power).  It isn't merged into 2.4 yet (I was hoping to
get he generic framework merged into 2.4-ac around start of October, but
alas it didn't happen).

It's going to be merged in 2.5, and then backported to 2.4.

> sa1100fb.c:166:26: asm/hardware.h: No such file or directory
> sa1100fb.c:169:28: asm/mach-types.h: No such file or directory
> sa1100fb.c:171:30: asm/arch/assabet.h: No such file or directory

Yes, these are ARM specific.  make dep creates the dependencies for all
files in the directory, and as such causes this problem.  That said, it
is harmless on x86, and safe to ignore these messages.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

