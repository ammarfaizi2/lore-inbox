Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267992AbUHKIlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267992AbUHKIlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 04:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUHKIls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 04:41:48 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:29382 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267992AbUHKIlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 04:41:44 -0400
Message-ID: <4119DAA2.3050206@eidetix.com>
Date: Wed, 11 Aug 2004 10:36:50 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Sascha Wilde <wilde@sha-bang.de>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <4107E788.8030903@eidetix.com> <41122C82.3020304@eidetix.com> <200408110131.14114.dtor_core@ameritech.net>
In-Reply-To: <200408110131.14114.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please try the patch below? I am interested in tests both with
> and without keyboard/mouse. The main idea is to leave ports that have been
> disabled by BIOS alone... The patch compiles but otherwise untested. Against
> 2.6.7.

The patch seems to work well! It doesn't apply completely cleanly
to my sources... maybe I left some of my own stuff in. On reboot, with
keyboard attached, I get this:

uart_close: bad serial port count; tty->count is 1, state->count2
  while rebooting the system.

drivers/input/serio/i8042.c: ff -> i8042 (kbd-data) [121813]

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [121886]

drivers/input/serio/i8042.c: aa <- i8042 (interrupt, kbd, 1) [122268]

drivers/input/serio/i8042.c: 20 -> i8042 (command) [122404]

drivers/input/serio/i8042.c: 45 <- i8042 (return) [122404]

drivers/input/serio/i8042.c: 60 -> i8042 (command) [122542]

drivers/input/serio/i8042.c: 65 -> i8042 (parameter) [122542]

Restarting system.

> BTW, do you both have the same motherboard/chipset? Maybe a dmi entry is in
> order...

Mine is a VIA chipset with an AMD processor:

http://www.ecsusa.com/products/km400-m2.html

How do I fetch the exact information that would be needed for a DMI entry?

Thanks much,
-- 
David N. Welton
davidw@eidetix.com

