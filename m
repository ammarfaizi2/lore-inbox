Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129648AbRBAOdx>; Thu, 1 Feb 2001 09:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129796AbRBAOdm>; Thu, 1 Feb 2001 09:33:42 -0500
Received: from mailserver-ng.cs.umbc.edu ([130.85.100.230]:9468 "EHLO
	mailserver-ng.cs.umbc.edu") by vger.kernel.org with ESMTP
	id <S129650AbRBAOdk>; Thu, 1 Feb 2001 09:33:40 -0500
To: linux-kernel@vger.kernel.org
Subject: ide hotplug and 2.4.1
From: Ian Soboroff <ian@cs.umbc.edu>
X-NSA-Fodder: strategic quiche munitions security
Date: 01 Feb 2001 09:27:02 -0500
Message-ID: <87hf2eo4w9.fsf@danube.cs.umbc.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've started playing with 2.4.1 on my Dell Latitude CS and it's pretty
peppy; my only complaints are PCMCIA-related, which i think i'll solve
by using the standalone package...

anyway, my real question is this.  i noticed the new options for
hotplug, and am wondering if i can use this with my laptop.  the
Latitude CS has a port on the side, with which you can connect a cable
that hooks up to either a floppy drive or a CDROM.

if you boot the machine cold with the CDROM attached, linux notices it
on a second IDE bus (/dev/hdc).  if you boot without it, /dev/hdc
isn't there.  if you plug in the CDROM while the system is running,
there is a noticeable pause for a couple seconds, which seems to imply
some kind of BIOS action or interrupt or something happens which could
be caught.

back in 2.2.x, i used to build IDE as a module, and after plugging up
the CDROM do a 'rmmod ide-probe; modprobe ide-probe' which had a
pretty good success rate.  i'm hoping maybe the 2.4.x hotplug features
have made this obsolete.

(plugging up the floppy drive always works, because PC floppy
controllers are too dumb to care if they actually have a drive
attached).

ian

-- 
----
Ian Soboroff                                       ian@cs.umbc.edu
University of MD Baltimore County      http://www.cs.umbc.edu/~ian
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
