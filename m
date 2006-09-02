Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWIBLV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWIBLV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 07:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWIBLV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 07:21:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18902 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751082AbWIBLV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 07:21:29 -0400
Date: Sat, 2 Sep 2006 13:21:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpu_init is called during resume
Message-ID: <20060902112116.GD1178@elf.ucw.cz>
References: <20060831135545.GM3923@elf.ucw.cz> <44F70A4B.4090803@goop.org> <20060831223121.GG12847@elf.ucw.cz> <44F7764A.7060707@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F7764A.7060707@goop.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-08-31 16:52:42, Jeremy Fitzhardinge wrote:
> Pavel Machek wrote:
> >We are doing virtual cpu hotplug/unplug... actually suspend to RAM
> >*and* disk. Just try it :-).
> >  
> 
> Yes, I know, but if you're replugging a CPU it should already have a GDT 
> allocated, so the kmalloc() won't be called in the resume case.  So if 
> there's a problem, it can only be on the resume-from-disk path, on the 
> assumption that that secondary CPU hasn't already been brought up.

I think gdt is destroyed on cpu unplug, no? I guess I'll have to redo
my testing...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
VGER BF report: H 0.410571
