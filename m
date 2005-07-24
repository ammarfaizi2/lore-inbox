Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVGXWfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVGXWfL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 18:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVGXWfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 18:35:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16653 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261481AbVGXWfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 18:35:08 -0400
Date: Sun, 24 Jul 2005 23:35:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix compilation in collie.c
Message-ID: <20050724233503.C20019@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20050721052527.GC7849@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050721052527.GC7849@elf.ucw.cz>; from pavel@ucw.cz on Thu, Jul 21, 2005 at 07:25:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 07:25:27AM +0200, Pavel Machek wrote:
> This fixes wrong number of arguments in call to write_scoop_reg, fixes
> map_name and John's email. Please apply,
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Nacked.

I'd like John (or someone) to look at this.  I'm particularly worred
about:

1. passing NULL into (read|write)_scoop_reg() - which use dev_get_drvdata()
   on this.  Given the choice between creating code which will definitely
   oops but not error or warn vs not compiling, I'll take not compiling
   any day.

2. whether this is supposed to be using the sharp chip driver rather
   than the cfi stuff.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
