Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273345AbTG3TYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273355AbTG3TYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:24:54 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:8634 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S273345AbTG3TW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:22:26 -0400
Date: Wed, 30 Jul 2003 21:18:01 +0200 (MEST)
Message-Id: <200307301918.h6UJI19q020560@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: albert@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: another must-fix: major PS/2 mouse problem
Cc: 0@pervalidus.tk, akpm@osdl.org, linux-yoann@ifrance.com, pavel@ucw.cz,
       vojtech@suse.cz, zwane@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 2003 08:29:32 -0400, Albert Cahalan wrote:
>> > > psmouse.c: Lost synchronization, throwing 3 bytes away.
>> > > psmouse.c: Lost synchronization, throwing 1 bytes away.
>> > > 
>> > > Arrrrgh! The TSC is my only good time source!
>> > 
>> > Arrrgh!  More PS/2 problems!
>> > 
>> > I think the lost synchronisation is the problem, would you agree?
>> > 
>> > The person who fixes this gets a Nobel prize.
...
>It won't make the mouse run well. Maybe you'd stop the
>mouse from going crazy from time to time, but there'd
>still temporary freezes from time to time. (not OK!)

FWIW, the problems my Dell Latitude had with the external
mice I use with it were significantly reduced once I added
"psmouse_noext" to the kernel's command line. That one
change eliminated all lost sync messages and general craziness
after resumes from suspended state.

To make the mouse move at proper speed w/o jerkiness I
also had to tweak the rate and scaling programmed into it
to match 2.4 defaults. (rate 100, scale 2:1)

In fairness, only my old Latitude has these PS/2 issues.

/Mikael
