Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVAONPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVAONPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVAONPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:15:48 -0500
Received: from smtp05.web.de ([217.72.192.209]:58816 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S262273AbVAONPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:15:38 -0500
Message-ID: <41E91795.9060609@web.de>
Date: Sat, 15 Jan 2005 14:16:05 +0100
From: Victor Hahn <victorhahn@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Really annoying bug in the mouse driver
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry if this mail goes to the wrong address or if I'm not providing the 
right information, but I'm just a regular user, not a hacker.

There is a really annoying bug in PS/2 mouse driver (this is psmouse.c I 
think). From time to time, the mouse is just going "crazy", just moving 
uncontrolledly over the screen and sometimes even clicking. After a 
short while, this goes back to normal. Sometimes, the uncontrolled 
behaviour does only occur while moving the mouse and the problem does 
not disappear without having the mouse moved a little.
If I switch to a console (e.g. CTRL+ALT+F1) and then back to X, this 
helps, too. After having this problem, I can find the following messages 
in /var/log/messages:

Jan 15 13:33:36 vic kernel: psmouse.c: bad data from KBC - bad parity
Jan 15 13:33:38 vic kernel: psmouse.c: Wheel Mouse at 
isa0060/serio1/input0 lost
 synchronization, throwing 3 bytes away.

Sometimes, only one of these messages appears; the number of bytes in 
the second message varies, but mostly it is 3.

This bug is dependent on the mainboard (on the chipset I think). Here is 
an excerpt from my output of lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP]
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)

Having installed completely the same operating system this problem does 
not occur on a computer which has an other mainboard (and another chipset).

The problem is also dependend on the mouse. With some mouses, this 
problem occurs very often, with other, it does only occur rarely and 
with others it does not occur at all (unfortunately, I don't have of 
mouse of the last type). It seems that budget mouses are mostly affected 
by this bug while expensive mouses (e.g. Microsoft) are mostly not 
affected. On the internet, I read that this may be due to a low-quality 
mouse cable, but anyway, this problem does not occur with M$ Windows.

It seems that all 2.6-kernels have this problem, although some people on 
the internet wrote that this problem did not occur with kernel 2.6.1. I 
have got the problem with kernel 2.6.3, 2.6.9 and 2.6.10-rc3.

I really hope you can fix this bug, because it sometimes makes work very 
uncomfortable and I neither want to buy a new mainboard nor an expensive 
mouse I don't need actually.

Regards,
Victor

