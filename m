Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSKGQIn>; Thu, 7 Nov 2002 11:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSKGQIn>; Thu, 7 Nov 2002 11:08:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48402 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261317AbSKGQIj>; Thu, 7 Nov 2002 11:08:39 -0500
Date: Thu, 7 Nov 2002 17:15:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
       Alan Cox <alan@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021107161517.GA6704@atrey.karlin.mff.cuni.cz>
References: <1036340733.29642.41.camel@irongate.swansea.linux.org.uk> <200211022006.gA2K6XW08545@devserv.devel.redhat.com> <20021103145735.14872@smtp.wanadoo.fr> <2117.1036674362@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2117.1036674362@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > The bigger picture really should be
> >  ACPI etc	"I want to suspend to disk" 
> 
> Er, what?
> 
> The 'I want to suspend to disk' instruction comes from the generic PM code 
> too, surely? ACPI just registers a handful of methods with the generic PM 
> code for actually doing stuff like entering sleep states, etc.

ACPI wants to enter S4 when user asks it to, and swsusp is the way to
do it. When machine overheats, ACPI wants to enter S4 too.

Of course there should be generic way (and it is, sys_reboot) to enter
S4 without asking acpi. echo 4 > /proc/acpi/sleep is just easier for
most people.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
