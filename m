Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSHUIRA>; Wed, 21 Aug 2002 04:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSHUIRA>; Wed, 21 Aug 2002 04:17:00 -0400
Received: from mail.iok.net ([62.249.129.22]:3086 "EHLO mars.iok.net")
	by vger.kernel.org with ESMTP id <S318047AbSHUIRA>;
	Wed, 21 Aug 2002 04:17:00 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Holger Schurig <h.schurig@mn-logistik.de>
To: linux-kernel@vger.kernel.org
Subject: cell-phone like keyboard driver anywhere?
Date: Wed, 21 Aug 2002 09:32:36 +0200
User-Agent: KMail/1.4.3
X-Archive: encrypt
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208210932.36132.h.schurig@mn-logistik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to write a keyboard driver for a cell-phone like keyboard. I'm just 
wondering if this has been done before.

Basically, the keys are in some x/y matrix. How to decode that can be seen in 
drivers/char/asi_keyboard.c (after applying the patches

ftp://ftp.arm.linux.org.uk/pub/armlinux/source/kernel-patches/v2.4/patch-2.4.18-rmk7.bz2 
ftp://source.mvista.com/pub/xscale/pxa/diff-2.4.18-rmk7-pxa3.gz
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=1187/1

However, this file (as any other that I have seen) assumes that there are 
shift, ctrl, alt etc layers. But a cell-phone like keyboard operates 
differently, e.g.

1 pause -> send keycode for character "a"
1 1 pause -> send keycode for character "b"
1 1 1 pause -> send keycode for character "c"
2 pause -> send keycode for character "d"

and so on.

Has anybody done things in this area?


Holger

