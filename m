Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVBVAIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVBVAIb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 19:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVBVAIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 19:08:31 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:28840 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S262187AbVBVAIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 19:08:20 -0500
Message-ID: <421A777F.1010802@nodivisions.com>
Date: Mon, 21 Feb 2005 19:06:23 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>            <421A4375.9040108@nodivisions.com> <200502212054.j1LKs3xi032658@turing-police.cc.vt.edu> <421A5E28.1030409@nodivisions.com> <421A6426.6020802@nortel.com>
In-Reply-To: <421A6426.6020802@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
>> It's indisputable that there will always be driver bugs and faulty 
>> hardware.  Of course these should be fixed, but if it's possible for 
>> the kernel to gracefully deal with the bugs until they get fixed, then 
>> why shouldn't it do so?
> 
> Think of the overhead required to track every single resource ever 
> aquired by the process/thread/entity in question.  Then if/when it 
> hangs, you'd have to properly clean up every last one of them.

Yes, that would be difficult and expensive.  But if permanently-D-stated 
processes happened monthly on 50% of systems, then wouldn't it be worth it? 
  How about weekly on 10% of systems?  The point is that at some point this 
becomes worth considering, and with more people adding more new hardware to 
their systems every day, this problem is becoming more and more frequent.

> Much safer/simpler to leave it hung, and force an eventual reboot.

"Eventual" makes it sound far away, but the reality is that if part of your 
USB subsystem is D-stated, then "eventually" means next time you want to use 
your USB stick, or your printer, or your digital camera, or your MP3 device, 
  or... In other words, "eventually" means "right now, interrupting all your 
current work."

> If you have been given code that causes D states, bitch to the supplier 
> until they fix it.

The driver code for my devices has "been given" to me as part of the kernel. 
  Any of a handful of USB devices has caused permanent D states, as has a 
CDROM and a NIC.  I guess I'll need to start debugging all of these drivers. 
  When something goes into permanent D sleep, what should I do to start 
tracking down the problem?  Aside from obvious stuff like dmesg and checking 
/var/log/messages, neither of which ever seems to say anything useful when 
this happens.

> Kernel bugs are not acceptable.

That's a nice-sounding ideal, but the truth is that kernel bugs exist and 
are not uncommon.

-Anthony DiSante
http://nodivisions.com/
