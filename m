Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVKJJuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVKJJuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVKJJuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:50:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56726 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750736AbVKJJuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:50:17 -0500
Date: Thu, 10 Nov 2005 10:48:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Josh Boyer <jwboyer@gmail.com>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, dwmw2@infradead.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051110094846.GB2021@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz> <625fc13d0511091619t135ec822t7f77aeb27e5db6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625fc13d0511091619t135ec822t7f77aeb27e5db6f@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Latest mtd changes break collie...it now oopses during boot. This
> > reverts the bad patch.
> >
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> >
> <snip>
> > -               for(i=0;i<100;i++){
> > -                       status = map_read32(map,adr);
> > -                       if((status & SR_READY)==SR_READY)
> > -                               break;
> > -                       udelay(1);
> > +               status = map_read32(map,adr);
> 
> I was just discussing with someone today how map_read32 no longer
> exists in the kernel...  does this even compile for you?
> 
> Somehow I think I'm missing something...

I had other changes in my tree. Only old_mtd+my_changes worked, but
new_mtd+my_changes broke, so I figured out diff between old_mtd and
new_mtd must be bad. Given that neither old_mtd compiled nor new_mtd
compiled...

Fixes to map_read32 are being prepared.

								Pavel
-- 
Thanks, Sharp!
