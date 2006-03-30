Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWC3M0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWC3M0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWC3M0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:26:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44046 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932192AbWC3M0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:26:02 -0500
Date: Thu, 30 Mar 2006 13:25:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>,
       lenz@cs.wisc.edu
Subject: 2.6.16-git18: collie_defconfig broken
Message-ID: <20060330122544.GA30314@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>,
	lenz@cs.wisc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kautobuild found the following error while trying to build 2.6.16-git18
using collie_defconfig:

arch/arm/mach-sa1100/collie.c:92: error: 'collie_uart_set_mctrl' undeclared here (not in a function)
arch/arm/mach-sa1100/collie.c:93: error: 'collie_uart_get_mctrl' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-sa1100/collie.o] Error 1
make: *** [arch/arm/mach-sa1100] Error 2
make: Leaving directory `/var/tmp/kernel-orig'

See

http://armlinux.simtec.co.uk/kautobuild/2.6.16-git18/collie_defconfig/zimage.log

for the full build log.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
