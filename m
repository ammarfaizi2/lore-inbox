Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUL1XUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUL1XUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUL1XUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:20:35 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:29344 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S261160AbUL1XU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:20:28 -0500
Message-ID: <41D1FA78.50203@softhome.net>
Date: Tue, 28 Dec 2004 16:29:44 -0800
From: Brannon Klopfer <plazmcman@softhome.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Screwy clock after apm suspend
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.10
Slackware 10/-current
IBM ThinkPad 600E
----------------

2.6.10 screws up my system clock.
Two kernel/hardware clock readings, before and after suspend.
-------------
plaz@gonzo:~$ date ;hwclock
Tue Dec 28 15:52:39 PST 2004
Tue Dec 28 14:54:07 2004 -0.503621 seconds
#suspend, resume
plaz@gonzo:~$ date ;hwclock
Tue Dec 28 16:11:58 PST 2004
Tue Dec 28 15:04:06 2004 -0.168262 seconds
---------------------
These are all when the comp is on without suspend (difference about the 
same throughout).
----------------
plaz@gonzo:~$ date ;hwclock
Tue Dec 28 16:14:52 PST 2004
Tue Dec 28 15:07:00 2004 -0.251812 seconds
plaz@gonzo:~$ date ;hwclock
Tue Dec 28 16:15:26 PST 2004
Tue Dec 28 15:07:34 2004 -0.236138 seconds
plaz@gonzo:~$ date ;hwclock
Tue Dec 28 16:19:48 PST 2004
Tue Dec 28 15:11:57 2004 -0.908540 seconds
plaz@gonzo:~$
------------
I did not have this problem with 2.6.9. My machine uses APM, clock 
stores local time (specified in kernel config). I use PIT for 
timesource, as others were losing ticks when on battery power (changes 
CPU clock speed). Again, did _not_ have this problem with 2.6.9.

Be glad to try out patches,
Brannon Klopfer
