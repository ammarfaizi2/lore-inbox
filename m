Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTJYQyM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 12:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTJYQyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 12:54:12 -0400
Received: from gprs198-24.eurotel.cz ([160.218.198.24]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262721AbTJYQyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 12:54:06 -0400
Date: Sat, 25 Oct 2003 18:53:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: [2.6.8-test8] swsusp
Message-ID: <20031025165351.GA211@elf.ucw.cz>
References: <20031025164300.GA2522@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025164300.GA2522@dreamland.darkstar.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> swsups works quite well for me, but there are some (minor) problems:
> 
> echo -n "disk" > /sys/power/state
> Stopping tasks: =======================================|
> Freeing memory: .............|
> hdd: start_power_step(step: 0)
> hdd: completing PM request, suspend
> hdc: start_power_step(step: 0)
> hdc: completing PM request, suspend
> hdb: start_power_step(step: 0)
> hdb: start_power_step(step: 1)
> hdb: complete_power_step(step: 1, stat: 50, err: 0)
> hdb: completing PM request, suspend
> hda: start_power_step(step: 0)
> hda: start_power_step(step: 1)
> hda: complete_power_step(step: 1, stat: 50, err: 0)
> hda: completing PM request, suspend
> [disks are now off]
> PM: Attempting to suspend to disk.
> PM: snapshotting memory.
> 
> Now disks spin up and data is written to the swap partition (hdb2), then
> the PC  powers off. The fact that  disks are stopped and  then restarted
> seems a bit strange to me.

Its normal.

> On resume I  see usual messages. hds  are on, then they  are powered off
> and turned on again and then the system is restored. I see also a lot of
> bad schedulings.
> 
> Another strange thing is that the shell dies:
> note: bash[394] exited with preempt_count 1
> 
> this was  the shell  where I  typed the  suspend command  (echo blabla),
> shells on other vc are alive.
> 
> I put dmesg (suspend + resume) here:
> http://web.tiscali.it/kronoz/linux/swsusp-2.6.0-t8.txt
> 
> Luca
> PS: who is the maintainer of swsusp now?

I'm maintainer of swsusp, but you are using pmdisk, that's Patrick
Mochel's code [=> complain to him]. Hopefully I'll merge pmdisk into
swsusp in future (say, 2.6.1?)
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
