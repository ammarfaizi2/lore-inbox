Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVLFH6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVLFH6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 02:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVLFH6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 02:58:48 -0500
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:59095 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S964776AbVLFH6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 02:58:46 -0500
Message-ID: <43954489.5040309@thinrope.net>
Date: Tue, 06 Dec 2005 16:58:01 +0900
From: Kalin KOZHUHAROV <kalin@thinrope.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Help track a memory leak in 2.6.0..14
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a Toshiba laptop (DynaBook SS/S5: PIIIM 800MHz, 256MB, 20GB 1.8" IDE) that has been running
all kernels since 2.6.0 (vanilla with occasional small patches) as a Gentoo machine.

Now, recently (a few months) I have been using it more and even as a desktop (leaving it up most of
the time). What I use 95% of the time is xorg/windowmaker/{xterm,firefox,thunderbird,gaim}...

The problem is that after some time memory is consumed (as `free -m` shows), response (kbd, mouse)
slows down to a stall and hard disk spins ad infinum (noise/ide LED). Sometimes I am able to switch
to a xterm/console and see that there is 2-3MB free memory, 1-2MB cached and 0-2MB buffers. Killing
all apps (X/WM included), `telinit 1` gives me something like 100-150MB used memory (not counting
buffers/cache) and virtually no apps are running. Restarting the machine, gives about 10-15MB used.
BTW, adding swap just slows down the process, but result is the same. Usually I work without swap.

Who uses that memory?
Why cannot be reclaimed by kernel?
WTF is the disk reading(writing?) all the time? (no swap)

So basically, how do I debug what process gets memory and doesn't release it?

At present (2.6.13.3) I need to reboot about once a day if I use the machine. And sometimes the only
way is coldboot or Alt+SysRq+{S;U,S,B}...

I am running almost the same config on a few other boxes but the problem does not seem to exist
(they have more memory though). The special thing on this laptop is the IDE and VGA subsystem:

00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 82)

The 1.8" HDD is: Device Model:     TOSHIBA MK2003GAH

All advice is appreciated!

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

