Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130655AbRBLP1L>; Mon, 12 Feb 2001 10:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130886AbRBLP1B>; Mon, 12 Feb 2001 10:27:01 -0500
Received: from [212.250.174.135] ([212.250.174.135]:13738 "EHLO 5emedia.net")
	by vger.kernel.org with ESMTP id <S130882AbRBLP0s>;
	Mon, 12 Feb 2001 10:26:48 -0500
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2022
Date: Mon, 12 Feb 2001 15:26:46 +0000
Subject: "Unable to load intepreter" on login - 2.2.14-5.0
From: Paul Tweedy <pault@5emedia.net>
To: <linux-kernel@vger.kernel.org>
Message-ID: <B6ADB136.3E08%pault@5emedia.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm at my wit's end. I've a Redhat 6.2 i386 box (6gb HD, 128mb RAM, 32mb
swap, kernel 2.2.14-5.0) which has been happily running as a dev server for
a good few months - Apache, PHP, MySQL, Samba and Netatalk being the most
heavily-used services. Nothing too load-heavy, maybe 5 users at once spread
across Netatalk and Samba.

All of a sudden over the weekend, it began to give 'Unable to load
interpreter' errors to the console. I've been unable to log in via any
means, although booting into single-user mode works fine. Under normal
circumstances the 'unable to load intepreter' message appears whenever a
username is entered, and the screen clears.

The research I've done pointed to this message being indicative of a memory
problem. I changed rc.local to up the requisite values in /proc/sys/vm to
see if that helped give the filesystem more legroom, but that yielded
nothing. Swap is hardly being used at all, and even rebooting with all the
usual services turned off made no difference, so I can't believe there's
something gobbling the memory. In single-user mode, top reports nothing
untoward - 99.8% CPU available, swap at 0% use, plenty of RAM available.

/var/log/messages reports nothing but the 'kernel : unable to load
intepreter /lib/ld-linux.so.2" error when someone tried to log in. The
symlink is there, as is the library it's pointing to. Sadly something else
screwed up over the weekend and all my previous logs disappeared - maybe
Cron (which I had creating a tarball of some of the system logs) went barmy
and caused all this, but it doesn't explain what's gone so wrong that it
won't fix itself when the server reboots, even with crond, etc disabled.

Has *anyone* got any clue, bar a complete reinstall? I'm picking this up as
I go along.. 

Severe amounts of thanks in advance,

Paul


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
