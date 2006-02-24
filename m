Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWBYAG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWBYAG1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWBYAG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:06:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52864 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964810AbWBYAG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:06:26 -0500
Date: Sat, 25 Feb 2006 00:40:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: My machine is cursed: no sound. Help! [was Re: es1371 sound problems]
Message-ID: <20060224234050.GA1644@elf.ucw.cz>
References: <20060223205309.GA2045@elf.ucw.cz> <s5h1wxtdmri.wl%tiwai@suse.de> <20060224161631.GB1925@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224161631.GB1925@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I've seen similar messages in some reports but haven't figured out the
> > cause yet.
> > 
> > To be sure, could you check the patch below, making the wait time in
> > codec acceessor longer?
> > Also, try to build ens1371 driver as a module.
> 
> Tried that... only msleep() hunks did apply, but that should be only
> more conservative, AFAICT. It took looong time to boot (my fault,
> should have used 50, not 0xa000 or how much is that), but same result
> as before. I tried loading it as a module, but same problem :-(.

I guess my machine is cursed. emu10k does not work -- produces no
sound. ens1371 does not work -- is not initialized. usb sound card --
produces no sound.

Now, I tried to break the curse by connecting usb sound card to
another machine... but guess what, still no sound. Connected to second
machine:

root@amd:~# cat /proc/asound/cards
 0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                      Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 5
 1 [U0x4fa0x4201   ]: USB-Audio - USB Device 0x4fa:0x4201
                      USB Device 0x4fa:0x4201 at usb-0000:00:1d.1-2, full speed
root@amd:~#

(usb soundcard clicks when I launch mpg123, but that's it.)

Any ideas?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
