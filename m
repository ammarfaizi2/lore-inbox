Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSKGQMX>; Thu, 7 Nov 2002 11:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbSKGQMW>; Thu, 7 Nov 2002 11:12:22 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:41459 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261401AbSKGQMV>; Thu, 7 Nov 2002 11:12:21 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021107161517.GA6704@atrey.karlin.mff.cuni.cz> 
References: <20021107161517.GA6704@atrey.karlin.mff.cuni.cz>  <1036340733.29642.41.camel@irongate.swansea.linux.org.uk> <200211022006.gA2K6XW08545@devserv.devel.redhat.com> <20021103145735.14872@smtp.wanadoo.fr> <2117.1036674362@passion.cambridge.redhat.com> 
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 16:18:54 +0000
Message-ID: <20003.1036685934@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pavel@ucw.cz said:
>  ACPI wants to enter S4 when user asks it to, and swsusp is the way to
> do it. When machine overheats, ACPI wants to enter S4 too.

> Of course there should be generic way (and it is, sys_reboot) to enter
> S4 without asking acpi. echo 4 > /proc/acpi/sleep is just easier for
> most people.

Why /proc/acpi/sleep ?

Other PM implementations gave us /proc/sys/pm/suspend -- why doesn't ACPI 
use that?

The stuff in /proc/acpi should be ACPI-specific. Anything _generic_ like 
battery info, sleep states, etc. should have a generic interface which can 
be used by any implementation. 

--
dwmw2


