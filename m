Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265973AbSKGUp3>; Thu, 7 Nov 2002 15:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265984AbSKGUp3>; Thu, 7 Nov 2002 15:45:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22020 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265973AbSKGUp2>; Thu, 7 Nov 2002 15:45:28 -0500
Date: Thu, 7 Nov 2002 21:52:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021107205206.GD28900@atrey.karlin.mff.cuni.cz>
References: <20021107161517.GA6704@atrey.karlin.mff.cuni.cz> <1036340733.29642.41.camel@irongate.swansea.linux.org.uk> <200211022006.gA2K6XW08545@devserv.devel.redhat.com> <20021103145735.14872@smtp.wanadoo.fr> <2117.1036674362@passion.cambridge.redhat.com> <20003.1036685934@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20003.1036685934@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  ACPI wants to enter S4 when user asks it to, and swsusp is the way to
> > do it. When machine overheats, ACPI wants to enter S4 too.
> 
> > Of course there should be generic way (and it is, sys_reboot) to enter
> > S4 without asking acpi. echo 4 > /proc/acpi/sleep is just easier for
> > most people.
> 
> Why /proc/acpi/sleep ?
> 
> Other PM implementations gave us /proc/sys/pm/suspend -- why doesn't ACPI 
> use that?

Well, /proc/sys/pm/suspend also does not seem like the right name for
suspend...

I believe sys_reboot() is the right way to do. Perhaps
/proc/acpi/sleep should be killed in favor of that?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
