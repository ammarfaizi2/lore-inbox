Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbTI3VBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbTI3VBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:01:52 -0400
Received: from 213-152-32-80.dsl.eclipse.net.uk ([213.152.32.80]:15765 "EHLO
	affronted.org") by vger.kernel.org with ESMTP id S261731AbTI3VA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:00:28 -0400
From: Paul Symons <paul@affronted.org>
Reply-To: paul@affronted.org
Subject: atkbd.c not recognising key on logitech cordless keyboard
Date: Tue, 30 Sep 2003 22:00:30 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200309302200.31040.paul@affronted.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a Logitech Cordless Desktop with those funny extra buttons at the 
top. However, one particular button no longer works when running development 
kernels (it worked in 2.4 kernels). The first development kernel I tested 
with was 2.5.75; it hasn't worked from then up until 2.6.0-test6, which I am 
running now.

The key in question is labelled "Messenger / SMS". When tailing 
/var/log/kern.log, and I press the key in question, I get this (I switched on 
debug in i8042.c and atkbd.c in case it helped):

Sep 30 21:55:32 fastpc kernel: drivers/input/serio/i8042.c: e0 <- i8042 
(interrupt, kbd, 1) [187205]
Sep 30 21:55:32 fastpc kernel: atkbd.c: Received e0 flags 00
Sep 30 21:55:32 fastpc kernel: drivers/input/serio/i8042.c: 11 <- i8042 
(interrupt, kbd, 1) [187208]
Sep 30 21:55:32 fastpc kernel: atkbd.c: Received 11 flags 00
Sep 30 21:55:32 fastpc kernel: atkbd.c: Unknown key pressed (translated set 2, 
code 0x11d, data 0x11, on isa0060/serio0).
Sep 30 21:55:32 fastpc kernel: drivers/input/serio/i8042.c: e0 <- i8042 
(interrupt, kbd, 1) [187383]
Sep 30 21:55:32 fastpc kernel: atkbd.c: Received e0 flags 00
Sep 30 21:55:32 fastpc kernel: drivers/input/serio/i8042.c: 91 <- i8042 
(interrupt, kbd, 1) [187387]
Sep 30 21:55:32 fastpc kernel: atkbd.c: Received 91 flags 00
Sep 30 21:55:32 fastpc kernel: atkbd.c: Unknown key released (translated set 
2, code 0x11d, data 0x91, on isa0060/serio0).

cat'ing /proc/bus/input/devices gave this for the keyboard

I: Bus=0011 Vendor=0001 Product=0002 Version=ab02
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd evbug
B: EV=120003
B: KEY=4 2200000 c061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe
B: LED=7


Is there anyway I can make this key work again?

Thanks for any help.

Paul

