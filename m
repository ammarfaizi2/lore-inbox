Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSDOJXr>; Mon, 15 Apr 2002 05:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313126AbSDOJXq>; Mon, 15 Apr 2002 05:23:46 -0400
Received: from employees.nextframe.net ([212.169.100.200]:58096 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S313125AbSDOJXp>; Mon, 15 Apr 2002 05:23:45 -0400
Date: Mon, 15 Apr 2002 11:23:32 +0200
From: Morten Helgesen <admin@nextframe.net>
To: martin@dalecki.de
Cc: linux-kernel@vger.kernel.org
Subject: [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup: idebus=66 -- BAD OPTION"
Message-ID: <20020415112332.A181@sexything>
Reply-To: admin@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Martin (and the rest of you)

Been testing 2.5.8 for an hour or so, and noticed the following :

[11:14][root@sexything:/home/admin]$ dmesg | grep idebus
Kernel command line: BOOT_IMAGE=2.5.8-without-TCQ ro root=303 video=matrox:vesa:0x118 idebus=66 profile=2
ide_setup: idebus=66 -- BAD OPTION

With 2.5.8-pre3 :

[11:15][root@sexything:/home/admin]$ cat ./IDEBUS
Kernel command line: BOOT_IMAGE=2.5.8-pre3 ro root=303 video=matrox:vesa:0x118 idebus=66 profile=2
ide_setup: idebus=66

Now, I do not know the reasons for changing the code that handles "idebus=" stuff in ide.c (except from the fact
that it now looks cleaner :) - just thought I should let you know. I do not have the time right now to hunt down
the bug(?) and cook up a patch, but if you want me to, I`ll do it later today. 

One more thing, Martin - I compiled a 2.5.8 with TCQ enabled (yep, I`m aware of the fact that this one is _really_ alpha :), 
and tested it for, oh ... 10 minutes ... the system gave me all sorts of funny responses - segfaults, 
"inconsistency in ld.so" and so on ... would you like me to collect 'funnies' and send them to you ? If so, just 
give me a hint.

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
