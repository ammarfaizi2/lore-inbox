Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWG3LJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWG3LJB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWG3LJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:09:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23695 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932263AbWG3LJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:09:00 -0400
Date: Sun, 30 Jul 2006 13:08:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       alsa-devel@alsa-project.org, mingo@elte.hu
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
Message-ID: <20060730110847.GH1920@elf.ucw.cz>
References: <20060727015639.9c89db57.akpm@osdl.org> <200607300931.07679.rjw@sisk.pl> <44CC68EE.1080208@gmail.com> <200607301128.04395.rjw@sisk.pl> <44CC8FD3.5030403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CC8FD3.5030403@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Please try to revert git-alsa.patch and see if the emu10k1-related problem
> >goes away.
> 
> Wow, it didn't helped, I find out there is a difference between in-kernel 
> and modules version of the driver. When compiled as modules 
> (loaded/unloaded) suspending (and resuming) is working ok (enabled higmem 
> and preempt back -- still no smp), when compiled in-kernel (see the config 
> diff below), it doesn't resume.

Yes, that sometimes happens. You could work around it by catching
PM_EVENT_PRETHAW message and resetting the hardware in this case. Or
just fix the resume routine.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
