Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267715AbTBUVTR>; Fri, 21 Feb 2003 16:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbTBUVTR>; Fri, 21 Feb 2003 16:19:17 -0500
Received: from [195.39.17.254] ([195.39.17.254]:28032 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267715AbTBUVTQ>;
	Fri, 21 Feb 2003 16:19:16 -0500
Date: Fri, 21 Feb 2003 17:10:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@redhat.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.62-ac1
Message-ID: <20030221161050.GA163@elf.ucw.cz>
References: <E6D19EE98F00AB4DB465A44FCF3FA46903A340@ns.cinet.co.jp> <200302211153.h1LBrYR12271@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302211153.h1LBrYR12271@devserv.devel.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Linux 2.5.62-ac1
> > > o	PC-9800 update			(Osamu Tomita)
> > Thanks!
> > 
> > > o	Toshiba keyboard workaround		(Pavel Machek)
> > This change conflict with PC98 keyboard. Always shows message
> > 'Keyboard glitch detected, ignoring keypress' every keypress.
> > Other machine has no problem?
> 
> I've had no other reports of it triggering wrongly. Thats easy to
> deal with. Pavel can you send me the dmidecode data for the afflicted
> laptop ?

arch/i386/kernel/dmi_scan.c, broken_toshiba_keyboard() is the right
place. DMI data are:

        { broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
                        MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
                        NO_MATCH, NO_MATCH, NO_MATCH
                        } },
 
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
