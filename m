Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbVGNKmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbVGNKmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbVGNKmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:42:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54289 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262977AbVGNKmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:42:36 -0400
Date: Thu, 14 Jul 2005 11:42:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Song <samlinuxkernel@yahoo.com>
Cc: mgreer@mvista.com, david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Message-ID: <20050714114220.C31383@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Song <samlinuxkernel@yahoo.com>, mgreer@mvista.com,
	david-b@pacbell.net, linux-kernel@vger.kernel.org
References: <20050713134837.B6791@flint.arm.linux.org.uk> <20050714071202.88368.qmail@web32007.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050714071202.88368.qmail@web32007.mail.mud.yahoo.com>; from samlinuxkernel@yahoo.com on Thu, Jul 14, 2005 at 12:12:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 12:12:02AM -0700, Sam Song wrote:
> It turned out the conflict of uart init definition 
> like MPC10X_UART0_IRQ in ../syslib/mpc10x_common.c 
> and SERIAL_PORT_DFNS in ../platform/sandpoint.h. By
> now, only MPC10X_UART0_IRQ stuff is needed. 
> SERIAL_PORT_DFNS should be omitted. 

Oh dear, it seems that I missed a load of fixups then.  I only
scanned include/asm-* for SERIAL_PORT_DFNS - and I stupidly
thought that PPC this "platform" directory would be in include/asm-ppc.

> Seems it's time for me to stand with Russell:-)

Well, in this case, the "whinging" resulted in finding a _real_ bug
and locating why your ports weren't being found.  So I guess it's
good for something.

Can you mail me a diff of the changes you made to
arch/ppc/platforms/sandpoint.h please?  If that file is being used
it seems that you actually have 4 ports defined in total.  However,
I'm a little confused because the sandpoint.h defines don't seem to
match your original dmesg output.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
