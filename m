Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUHHSyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUHHSyI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUHHSyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:54:08 -0400
Received: from gprs214-39.eurotel.cz ([160.218.214.39]:7808 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266141AbUHHSyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:54:06 -0400
Date: Sun, 8 Aug 2004 20:53:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -mm swsusp: fix highmem handling
Message-ID: <20040808185352.GA4919@elf.ucw.cz>
References: <20040728222300.GA16671@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728222300.GA16671@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> Swsusp was not restoring highmem properly. I did not find a nice place
> where to restore it, through, so it went to swsusp_free.
> 
> I'm not sure why you are saving state before
> save_processor_state. swsusp_arch_resume will overwrite this,
> anyway. Is it to make something balanced?

On your suggestion (sorry, I do not have it nearby) I tried moving
restore_highmem into swsusp_resume, and it crashed. I'll try moving it
around.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
