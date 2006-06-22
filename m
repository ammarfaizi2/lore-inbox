Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWFVSRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWFVSRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWFVSRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:17:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3798 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751519AbWFVSRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:17:50 -0400
Date: Thu, 22 Jun 2006 20:16:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dave Jones <davej@redhat.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060622181658.GA4193@elf.ucw.cz>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com> <20060619222528.GC1648@openzaurus.ucw.cz> <Pine.LNX.4.61.0606201156080.2481@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606201156080.2481@yvahk01.tjqt.qr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >If it happens to you... you needed a new cpu anyway. Anything non-historical
> >*has* thermal protection.
> >
> >BTW I doubt those old athlons can be saved by cli; hlt . (Someone willing 
> >to try if old
> >athlon can run cli; hlt code w/o heatsink?).
> 
> K6 run cooler even with the regular kernel HLT (sti/hlt I presume). 
> Difference to full load can be up to 10 deg, depending on ambient (room) 
> temperature. In winter (read 2005-12-31) it ran between 28 celsius and 34 
> celsius. The fan even stopped and I thought it was a fan failure, but 
> luckily it was just hw-controlled :)

Okay, so you've got a point. The patch is useful on k6 in the winter
:-). (Actually, to show you've got a point, you'd have to stop the fan
and show that cpu badly overheats under for(;;) conditions).

Yes, we probably want to consolidate various for(;;) loops... and
maybe it will helpsomeone. If overheating causes reboot instead of
panic, you probably still loose, as BIOS is close to for(;;)...

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
