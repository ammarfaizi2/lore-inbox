Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130921AbRCGKa7>; Wed, 7 Mar 2001 05:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130960AbRCGKat>; Wed, 7 Mar 2001 05:30:49 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:44214 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S130921AbRCGKan>; Wed, 7 Mar 2001 05:30:43 -0500
Date: Wed, 7 Mar 2001 10:33:50 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: Alex Baretta <alex@baretta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Major system crash 2.2.14 HELP!!!
In-Reply-To: <000501c0a6df$7e5e4900$396dc6d4@alex.cybercable.fr>
Message-ID: <Pine.LNX.4.21.0103071016460.13603-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Hm, ok, let me be the first to reply to you, although I am far not a good
specialist in this area, I just hope to provoke somebody to give more
professional answers to your problem:-)

1) Try using dd to copy your entire disk to another one (if that's
possible), it anyway would be a good starting point, I guess. Smth. like
(boot from a floppy, supposing your damaged drive is hda and you copy it
to hdb)
dd if=/dev/hda of=/dev/hdb
2) ok, now that we have (hopefully) preserved what was possible we can
attempt more risky steps: while booted from a floppy do
mount -r /dev/hda /mnt
and see what's left on your drive...
3) Now you can attempt various fsck's, but be warned - this is where you
already CAN make matters worse... First umount
umount /dev/hda
then smth like
e2fsck /dev/hda
...

Good luck
Guennadi

P.S. Hey, guys, I know it's a bit off-topic here, but some (all?) of you
can help this chap out better than me - please correct what I've said
wrong.

On Wed, 7 Mar 2001, Alex Baretta wrote:

> I desperately need your help. I booted my machine 15 minutes ago,
> pressed return at the LILO prompt to load the default kernel, waited
> for the visual login screen to appear, I logged on to my account (not
> root), started a terminal and ... and that's as much as I can tell
> you. I left the computer for a few minutes to prepare my breakfast,
> and when I sat down to my machine with my bowl of cereals in front of
> me, I saw a most horrific vision: the LILO prompt once again. The
> machine crashed so severely it rebooted directly without showing any
> previous signs of agony. And what is worse, the machine now refuses to
> start up. It tells me the superblock of some device does not pass file
> system check (superblock is damaged). If offers me the possibility of
> pressing Ctrl-D to resume the boot process or the possibility to type
> my root password and start a shell. Ctrl-D results in the machine
> observing that it can do nothing but force a reboot. The root password
> takes me into a shell where I see the usual directories, but most of
> them are empty. And what's even worse is that my data (home directory)
> has been blown to interstellar dust.
> 
> I have frequently experienced system crashes on my machine. What would
> happen exactly is that the machine would become totally unresponsive.
> The mouse pointer would usually disappear, and no key combination
> (Ctrl-Alt-Del, Ctrl-Alt-BS, Shit-Alt-Fn) would obtain any result, and
> would very simply have to reboot the hard way. The frequence actually
> appeared to be very random. Some days I would spend in the excess of
> 12 hours working at my computer and never rebooting. Other days I
> remeber having had to reboot every few minutes. Originally I
> attributed this phenomenon to an overheating of the drives [ I have 3
> IDE drives which _used_to_ run merrily in my case... 8-(     ] Then  I
> moved them to a one bay distance from one another, thereby greatly
> reducing the temperature they reached, but this did not solve the
> random system crashes.
> 
> Now my machine was completely cold after one night's rest. I boot up
> correctly once, committed suicide, and all I have got is it's corpse.
> What can I do? I could reinstall Linux, but first I have to try to get
> my /home directory copied somewhere (to my other HD, for example, the
> where I keep the Dark Side of the Force handy, for emergencies ... ).
> How can I do this? What information can I _attempt_ to recover by
> inspecting the cadaver (logs and the like that help a guru or two
> figure out what happened?
> 
> Please, help me urgently. I am in such distress!
> 
> Alex
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


