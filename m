Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUBHGSj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 01:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUBHGSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 01:18:39 -0500
Received: from bgp01038448bgs.sothwt01.mi.comcast.net ([68.43.98.24]:9386 "EHLO
	fire-eyes.dynup.net") by vger.kernel.org with ESMTP id S262360AbUBHGSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 01:18:37 -0500
Message-ID: <4025D4BF.7010309@fire-eyes.dynup.net>
Date: Sun, 08 Feb 2004 01:18:39 -0500
From: fire-eyes <sgtphou@fire-eyes.dynup.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.2: psmouse.c: .... Mouse at isa0060/serio1/input0 lost synchronization,
 throwing 3 bytes away.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Please CC: me, as I am not subscribed to this list.


I am using kernel 2.6.2 with SMP support on an Asus A7M-266D 
motherboard. I am using a Logitech M-BJ69 ps/2 mouse.

While in xfree, twice today I had the following happen:

While using the mouse, the pointer suddenly jumped wildly all over the 
place, I heard exactly two PC speaker beeps, then I got control back. 
This took about a quarter second in total. After that, no mouse button 
worked, including wheels.

I ctl-alt-backspace out of xfree. I check my load and it is high. I'm 
using xfce 4.0.3 window manager, and xfwm4 is taking up 99.9% of cpu. I 
need to kill -9 it. Not sure if xfce4 is actually a problem, I don't see 
how it would affect the mouse.

Both times I got the following error in logs:

kernel: psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost 
synchronization, throwing 3 bytes away.

Here is some more info on my system:

Gentoo Linux
glibc-2.3.3_pre20040117
gcc (GCC) 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)
xfree 4.3.99.902

Now what stands out there is the xfree version. I never had this error 
in 4.3.0.

Starting xfree and xfce4, I get the following in logs. And yes it really 
is this many times:

atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on 
isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.


Is there any further info I can provide to help solve a possible problem?

Thanks!
