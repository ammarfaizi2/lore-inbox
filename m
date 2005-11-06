Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVKFKJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVKFKJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 05:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVKFKJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 05:09:10 -0500
Received: from wscnet.wsc.cz ([212.80.64.118]:37765 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932347AbVKFKJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 05:09:09 -0500
Message-ID: <436DD635.9030103@gmail.com>
Date: Sun, 06 Nov 2005 11:08:53 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
References: <E1EYdMs-0001hI-3F@think.thunk.org>
In-Reply-To: <E1EYdMs-0001hI-3F@think.thunk.org>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o napsal(a):

>When I upgraded to 2.6.14 from 2.6.14-rc5, my X server failed to stop.  
>Investigation revealed it was because my CorePointer was the Synaptics
>driver, and the device corresponding to the Synaptics touchpad
>(/dev/input/event2 on my laptop) was not being created.  Once I manually
>created the device with the proper major/minor device numbers, X started
>correctly.
>
>A comparison of "udevinfo -e" on 2.6.14-rc5 and 2.5.14 reveals the
>following differences.  Was this change deliberate?  And can it be
>reverted?
>
>Thanks, 
>
>						- Ted
>
>
>--- udevinfo-2.6.14-rc5	2005-11-06 00:17:06.000000000 -0500
>+++ udevinfo-2.6.14	2005-11-06 00:22:42.000000000 -0500
>@@ -86,27 +86,15 @@
> P: /class/cpuid/cpu0
> N: cpu/0/cpuid
> 
>-P: /class/input/event0
>-N: input/event0
>-
>-P: /class/input/event1
>-N: input/event1
>-
>-P: /class/input/event2
>-N: input/event2
>-
>-P: /class/input/event3
>+P: /class/input/input3/event3
> N: input/event3
> 
>+P: /class/input/input3/mouse1
>+N: input/mouse1
>+
> P: /class/input/mice
> N: input/mice
> 
>-P: /class/input/mouse0
>-N: input/mouse0
>-
>-P: /class/input/mouse1
>-N: input/mouse1
>-
> P: /class/misc/device-mapper
> N: mapper/control
>  
>
You should also write which version of udev do you use.

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

