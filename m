Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVGWAbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVGWAbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVGWAbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:31:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41687 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262250AbVGWAbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:31:37 -0400
Date: Sat, 23 Jul 2005 02:31:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume... (non-fbdev/con)
Message-ID: <20050723003140.GB1988@elf.ucw.cz>
References: <Pine.LNX.4.58.0507221942540.5475@skynet> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dw6lc-0007IU-00@chiark.greenend.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	At OLS at lot of people were giving out about cards not resuming,
> > so using a patch from Michael Marineau and help from lots of people
> > sitting around in a circle at OLS I've gotten a patch that restores video
> > on my laptop by going into real mode and re-posting the BIOS during
> > resume,
> 
> On laptops, the code at c000:0003 may jump to BIOS code that isn't
> present after system boot. In userspace, this isn't too much of a
> problem - the userspace code tends to just fall over rather than hanging
> the machine. What happens if the kernel hits illegal or inappropriate
> code on resume?
> 
> I'm still fairly convinced that the best approach here is to carry it
> out in userspace, though this may require some support for asking
> framebuffers not to try to print anything until userspace is running.
> The only "real" solution is for the framebuffer drivers to know how to
> program the chip from scratch.

Unfortunately, if you only get printk() working after you ran
userspace app... well it makes debugging things like SATA
"interesting". So I quite like this patch.

If your BIOS does something wrong, well... your machine crashes.

							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
