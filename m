Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVGSTVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVGSTVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 15:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVGSTVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 15:21:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41692 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261991AbVGSTVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 15:21:20 -0400
Date: Tue, 19 Jul 2005 21:21:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Sharp Zaurus sl-5500 broken in 2.6.12
Message-ID: <20050719192104.GB32757@elf.ucw.cz>
References: <20050711193454.GA2210@elf.ucw.cz> <33703.127.0.0.1.1121130438.squirrel@localhost> <20050719180624.GB15186@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719180624.GB15186@atrey.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ...and that's well known; but now I did some back tracking, and
> 2.6.12-rc1 works, 2.6.12-rc2 does *not* and 2.6.12-rc2 with arm
> changes reverted works. I'll play a bit more.

This fixes at least one break-the-boot bug in -rc2...

							Pavel

--- linux-z11.rc2bad/arch/arm/mach-sa1100/collie.c	2005-07-19 20:49:07.000000000 +0200
+++ linux-z11/arch/arm/mach-sa1100/collie.c	2005-07-19 21:05:54.000000000 +0200
@@ -235,7 +235,7 @@
 	sa11x0_set_flash_data(&collie_flash_data, collie_flash_resources,
 			      ARRAY_SIZE(collie_flash_resources));
 
-	sharpsl_save_param();
+//	sharpsl_save_param();
 }
 
 static struct map_desc collie_io_desc[] __initdata = {


-- 
teflon -- maybe it is a trademark, but it should not be.
