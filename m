Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWHPWGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWHPWGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWHPWGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:06:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20372 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750730AbWHPWGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:06:37 -0400
Date: Thu, 17 Aug 2006 00:06:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: peculiar suspend/resume bug.
Message-ID: <20060816220618.GA17432@elf.ucw.cz>
References: <20060815221035.GX7612@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815221035.GX7612@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's a fun one.
> - Get a dual core cpufreq aware laptop (Like say, a core-duo)
> - Add a cpufreq monitor to gnome-panel. Configure it
>   to watch the 2nd core.
> - Suspend.
> - Resume.
> 
> Watch the cpufreq monitor die horribly.
> 
> I believe this is because we take down the 2nd core at suspend
> time with cpu hotplug, and for some reason we're scheduling
> userspace before we bring that second core back up.
> 
> Anyone have any clues why this is happening?

Its by design, we do unplug first. Okay, maybe it is more of design
bug :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
