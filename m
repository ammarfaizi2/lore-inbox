Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTJYQpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 12:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTJYQpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 12:45:16 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:11686 "EHLO
	mail-2.tiscali.it") by vger.kernel.org with ESMTP id S262714AbTJYQpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 12:45:09 -0400
Date: Sat, 25 Oct 2003 18:43:00 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: "Pavel Machek" <pavel@suse.cz>, "Patrick Mochel" <mochel@osdl.org>
Subject: [2.6.8-test8] swsusp
Message-ID: <20031025164300.GA2522@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
swsups works quite well for me, but there are some (minor) problems:

echo -n "disk" > /sys/power/state
Stopping tasks: =======================================|
Freeing memory: .............|
hdd: start_power_step(step: 0)
hdd: completing PM request, suspend
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hdb: start_power_step(step: 0)
hdb: start_power_step(step: 1)
hdb: complete_power_step(step: 1, stat: 50, err: 0)
hdb: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
[disks are now off]
PM: Attempting to suspend to disk.
PM: snapshotting memory.

Now disks spin up and data is written to the swap partition (hdb2), then
the PC  powers off. The fact that  disks are stopped and  then restarted
seems a bit strange to me.

On resume I  see usual messages. hds  are on, then they  are powered off
and turned on again and then the system is restored. I see also a lot of
bad schedulings.

Another strange thing is that the shell dies:
note: bash[394] exited with preempt_count 1

this was  the shell  where I  typed the  suspend command  (echo blabla),
shells on other vc are alive.

I put dmesg (suspend + resume) here:
http://web.tiscali.it/kronoz/linux/swsusp-2.6.0-t8.txt

Luca
PS: who is the maintainer of swsusp now?
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Porc i' mond che cio' sott i piedi!
V. Catozzo
