Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTCCOUA>; Mon, 3 Mar 2003 09:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTCCOUA>; Mon, 3 Mar 2003 09:20:00 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:11920 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id <S265361AbTCCOT7>;
	Mon, 3 Mar 2003 09:19:59 -0500
Date: Mon, 3 Mar 2003 15:30:06 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Troels Haugboelle <troels_h@astro.ku.dk>
Cc: Pavel Machek <pavel@suse.cz>, bert hubert <ahu@ds9a.nl>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303143006.GA1289@k3.hellgate.ch>
Mail-Followup-To: Troels Haugboelle <troels_h@astro.ku.dk>,
	Pavel Machek <pavel@suse.cz>, bert hubert <ahu@ds9a.nl>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl> <20030303122325.GA20929@atrey.karlin.mff.cuni.cz> <20030303123551.GA19859@outpost.ds9a.nl> <20030303124133.GH20929@atrey.karlin.mff.cuni.cz> <1046700474.3782.197.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046700474.3782.197.camel@localhost>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[removed ACPI mailing list from cc:]

On Mon, 03 Mar 2003 15:07:54 +0100, Troels Haugboelle wrote:
> just to add my experience. Maybe it helps. I haven't been able to get
> swsusp working on any 2.4.x kernel until i did an
>     hdparm -u1 /dev/hda
> now the strange thing: I tried to turn on the frame buffer device and
> it started chrashing again until i did
>     hdparm -u0 /dev/hda
> Before I tried using suspend in 2.5.x with varying success. Now
> everything runs like a charm. Without unmask irq's first the kernel
> dumped
> with either a kernel BUG statement or a fault in ide-disk.c

Not sure I follow all of your story but I can confirm that hdparm -u1
successfully gets me to the kernel panic due to highmem support still
lacking -- i.e. way beyond the BUG_ON() I've been hitting. So it looks
like you found a good work-around.

FWIW I'm using reiserfs, too. Two harddisks, ALi chipset.

Roger
