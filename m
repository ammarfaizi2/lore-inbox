Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVGPKQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVGPKQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 06:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVGPKQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 06:16:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48402 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261409AbVGPKQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 06:16:03 -0400
Date: Sat, 16 Jul 2005 11:15:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Song <samlinuxkernel@yahoo.com>
Cc: mgreer@mvista.com, david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-git] 8250 tweaks
Message-ID: <20050716111556.L19067@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Song <samlinuxkernel@yahoo.com>, mgreer@mvista.com,
	david-b@pacbell.net, linux-kernel@vger.kernel.org
References: <20050716094359.B19067@flint.arm.linux.org.uk> <20050716101201.46965.qmail@web32014.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050716101201.46965.qmail@web32014.mail.mud.yahoo.com>; from samlinuxkernel@yahoo.com on Sat, Jul 16, 2005 at 03:12:01AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2005 at 03:12:01AM -0700, Sam Song wrote:
> Still one puzzle related serial port. That's interrupt itself. I
> enabled two serial ports attached two different interrupt levels
> like 9/10 with disable interrupt shared. How come only one appeared 
> in /proc/interrupts? What could be on your platform or they should be?

The interrupts are only claimed when the port is actually opened, so if
only one port was open, you'll only see one appearing in /proc/interrupts.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
