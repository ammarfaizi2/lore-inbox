Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbUKPM7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbUKPM7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 07:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUKPM7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 07:59:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34323 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261970AbUKPM6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 07:58:47 -0500
Date: Tue, 16 Nov 2004 12:58:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: 2.6.10-rc2: parport_pc is broken
Message-ID: <20041116125842.A20648@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing this with CONFIG_PCI=n (which is fairly common for ARM
machines):

drivers/parport/parport_pc.c:3199: error: `parport_init_mode' undeclared (first use in this function)
drivers/parport/parport_pc.c:3199: error: (Each undeclared identifier is reported only once
drivers/parport/parport_pc.c:3199: error: for each function it appears in.)

It seems to have broken with the VT8231 addition on 7 Nov 2004.

Maybe we need to test kernel builds with CONFIG_PCI=n as part of a
standard test set?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
