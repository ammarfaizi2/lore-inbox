Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbTDUPn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbTDUPn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:43:28 -0400
Received: from [65.244.37.61] ([65.244.37.61]:29872 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S261390AbTDUPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:43:22 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A9201F93714@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: RE: [ALSA] no sound with Maestro3
Date: Mon, 21 Apr 2003 11:55:32 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I checked the bug report which says that you can play sound.  If so
ignore this post.

If not, follow the instructions found on the ALSA site, alsa-project.org,
for your card.  Note especially the section on 'Setting up modprobe'.
The error "request_module[snd-card-0]: not ready" indicates that
modprobe.conf
does not have the necessary entries. You should not get any such errors once

modprobe.conf is correct.

Make sure that all the correct devices are in /dev, both for OSS and ALSA
devices, major 14 and 116 if I remember right.

Once this is done, use amixer to check the mixer settings.  The defaults are
all channels mute, minimum gain, maximum attenuation.  amixer will let
you set everything, and store those settings as the new defaults.  If amixer
complains about anything, there is still a problem with one of the above two
setups.

If all this works, and you still have no sound, then you are where I am with
ALSA 0.9.2 and kernel 2.5.67bk2 - everything is working, according to ALSA,
tracing statements in the ICH4 driver, etc, but no sound.  I am about ready
to o-scope the AC97 lines!

-----Original Message-----
From: Paolo Ciarrocchi [mailto:ciarrocchi@linuxmail.org]
Sent: Sunday, April 20, 2003 6:36 AM
To: linux-kernel@vger.kernel.org
Subject: [ALSA] no sound with Maestro3


Hi,
I think I undestood wich is the option that cause the error I reported,
[ ]     OSS Sequencer API
If I enable that option I get the following error
request_module: failed /sbin/modprobe -- snd-card-0. error = -16

Now my dmesg is:
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57
2003 UTC).
PCI: Found IRQ 5 for device 00:0d.0
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1
  #2: ESS Maestro3 PCI at 0x1800, irq 5
  
But I still not able to play _any_ sound, I don't think that it is a problem
with my init scripts because with 2.4 I have _no_ problem.

I've updated the bugzilla's bug report,
http://bugzilla.kernel.org/show_bug.cgi?id=395

Any hint ?

Ciao,
        Paolo


-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
