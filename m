Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUA0KLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 05:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUA0KLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 05:11:40 -0500
Received: from ip503cf2e8.speed.planet.nl ([80.60.242.232]:1542 "EHLO
	www.robertvanherk.nl") by vger.kernel.org with ESMTP
	id S263082AbUA0KLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 05:11:38 -0500
Message-ID: <40163820.9070105@students.cs.uu.nl>
Date: Tue, 27 Jan 2004 11:06:24 +0100
From: Robert van Herk <rherk@students.cs.uu.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PS/2 Mouse problems with kernel 2.6.2_rc2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I have problems with my ps/2 mouse and keyboard under kernel 2.6.2_rc2.

Whenever the system is under heavy load, the mouse goes crazy. Also the 
keyboard start dropping characters or responding slow. Waiting with 
keyboad and mouse input for about half a minute sometimes solves the 
problem.

dmesg gives the following errors:
psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 
2 bytes away.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.

These messages actually occur more than once.

I have seen that messages like these occur more than once on the mailing 
list, though in my case putting psmouse_noext to the boot options didn't 
solve the issue.

This is the hardware used:
PS/2 mouse. Check one with and one without scrollwheel, same results.
AMD Athlon 2400+
512 MB Memory
1 80 gig IDE harddisk

Asus A7V333-X motherboard

Furthermore, some exotic hardware: Medion MD2819 television card.

It seems that the messages occur when heavy disk activity takes place. 
It looks like the harddisk gets priority over the mouse, causing the 
mouse to drop bytes, but ofcourse this is pure guessing. Anyhow, the 
symptom is that whenever heavy disk activity takes places, the mouse 
responds sluggish at first and later goes totally crazy...

Does anyone have any clues? For example: am I doing wrong or is it a 
kernel bug ;-)?

Greetings,
Robert
