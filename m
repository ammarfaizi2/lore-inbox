Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268644AbTGOPjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268676AbTGOPjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:39:35 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:27099 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S268644AbTGOPjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:39:11 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Peter Osterlund <petero2@telia.com>
Subject: Re: 2.6.0-test1: Synaptics driver makes touchpad unusable
Date: Tue, 15 Jul 2003 17:53:59 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307151244.53276.gallir@uib.es> <m2znjgj5zs.fsf@telia.com>
In-Reply-To: <m2znjgj5zs.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151753.59165.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 July 2003 15:04, Peter Osterlund shaped the electrons to shout:
> Ricardo Galli <gallir@uib.es> writes:
> > The new synaptics driver doesn't work with Dell Latitude Touchpad, it
> > doesn't work any /dev/input/event?|mouse? and /dev/psaux neither (altough
> > the same configuration worked at least until 2.5.70).
> >
> > I tried with gpm and the X's synaptics driver from
> > http://w1.894.telia.com/~u89404340/touchpad/index.html (as indicated in
> > the kernel documentation) and none worked, although "cat <
> > /dev/input/event0" showed garbage every time I touched the touchpad (no
> > pun intended) iff evdev was loaded.
> >
> > $ dmesg
> > ...
> > mice: PS/2 mouse device common for all mice
> > i8042.c: Detected active multiplexing controller, rev 1.1.
> > serio: i8042 AUX0 port at 0x60,0x64 irq 12
> > serio: i8042 AUX1 port at 0x60,0x64 irq 12
> > serio: i8042 AUX2 port at 0x60,0x64 irq 12
> > synaptics reset failed
> > synaptics reset failed
> > synaptics reset failed
>
> You probably need this patch.
>
> --- linux/drivers/input/mouse.resume/psmouse-base.c	Sat Jul  5 23:39:14
> 2003 +++ linux/drivers/input/mouse/psmouse-base.c	Sun Jul  6 00:23:17 2003
> @@ -201,7 +201,7 @@


Tried it, but still doesn't work. X server says cannot query/intialize de 
device as before:

i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
synaptics reset failed
synaptics reset failed
synaptics reset failed
Synaptics Touchpad, model: 1
 Firware: 5.9
 180 degree mounted touchpad
 Sensor: 37
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio4




Thanks.

-- 
  ricardo galli       GPG id C8114D34

