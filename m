Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSK3XxJ>; Sat, 30 Nov 2002 18:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSK3XxJ>; Sat, 30 Nov 2002 18:53:09 -0500
Received: from dot.freshdot.net ([195.64.80.165]:33042 "EHLO dot.freshdot.net")
	by vger.kernel.org with ESMTP id <S261333AbSK3XxI>;
	Sat, 30 Nov 2002 18:53:08 -0500
Date: Sun, 1 Dec 2002 01:00:34 +0100
From: Sander Smeenk <ssmeenk@freshdot.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 results
Message-ID: <20021201000034.GA22081@dot.freshdot.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After a little struggle with 2.5.50 and it's new modules system I got
things running on my Toshiba laptop.

Now there's a couple of things:

1) I get these messages while typing just normal stuff on my keyboard:
| Dec  1 00:28:00 misery kernel: atkbd.c: Unknown key (set 2, scancode 0x96, on isa0060/serio0) pressed.
| Dec  1 00:28:10 misery kernel: atkbd.c: Unknown key (set 2, scancode 0xae, on isa0060/serio0) pressed.
| Dec  1 00:28:13 misery kernel: atkbd.c: Unknown key (set 2, scancode 0x91, on isa0060/serio0) pressed.
| Dec  1 00:28:23 misery kernel: atkbd.c: Unknown key (set 2, scancode 0xa3, on isa0060/serio0) pressed.
| Dec  1 00:28:38 misery kernel: atkbd.c: Unknown key (set 2, scancode 0xa6, on isa0060/serio0) pressed.
I'm not doing anything funny at that moment, just typing commands.
Messaged appear at a random interval and at random keys.

2) Apparently when one boots 2.5.50 without having the newest
module-init-tools, the kernel panics while doing a shutdown.
Unfortunately I can't give much more information, because now I have the
new module-init-tools, and when it happened, all I could see was the
last bit of the panic.

Lastly, while loading modules:

| [0:57] [root@misery:~] # modprobe trident
| WARNING: Error inserting ac97_codec
| (/lib/modules/2.5.50/kernel/ac97_codec.o): Invalid module format
| FATAL: Error inserting trident (/lib/modules/2.5.50/kernel/trident.o):
| Unknown symbol in module
| zsh: 456 exit 1     modprobe trident
| [0:57] [root@misery:~] # 

'trident' is the driver for my laptop's soundcard. But it fails to load.

HTH,
Sander.

-- 
| Why is the time of day with the slowest traffic called rush hour?
| 1024D/08CEC94D - 34B3 3314 B146 E13C 70C8  9BDB D463 7E41 08CE C94D
