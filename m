Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUHFIXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUHFIXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 04:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUHFIXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 04:23:44 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:3209 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265410AbUHFIXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 04:23:05 -0400
Message-ID: <41133FE1.2040906@eidetix.com>
Date: Fri, 06 Aug 2004 10:22:57 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Lamanna <jamesl@appliedminds.com>
CC: Sascha Wilde <wilde@sha-bang.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <4112A626.1000706@appliedminds.com>
In-Reply-To: <4112A626.1000706@appliedminds.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Re-added Sascha to the CC, as he's interested in this too. ]

James Lamanna wrote:

> Change i8042.c:62 to
> #define DEBUG
> And see what printk's you get on trying to reboot.
> i8042_command has a bunch in it that are turned off by default.

Excellent suggestion.

*With keyboard* :

mice: PS/2 mouse device common for all mice 

drivers/input/serio/i8042.c: 20 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 65 <- i8042 (return) [0] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [0] 

drivers/input/serio/i8042.c: d3 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [0] 

drivers/input/serio/i8042.c: 5a <- i8042 (return) [0] 

drivers/input/serio/i8042.c: a9 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 00 <- i8042 (return) [0] 

drivers/input/serio/i8042.c: a7 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 20 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 74 <- i8042 (return) [0] 

drivers/input/serio/i8042.c: a8 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 20 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 54 <- i8042 (return) [0] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 74 -> i8042 (parameter) [0] 

drivers/input/serio/i8042.c: d3 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [0] 

drivers/input/serio/i8042.c: f0 <- i8042 (return) [0] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [0]
serio: i8042 AUX port at 0x60,0x64 irq 12 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [49] 

drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [49] 

drivers/input/serio/i8042.c: d4 -> i8042 (command) [49] 

drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [49] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [99] 

drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 0) [149] 

drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 0) [199] 

drivers/input/serio/i8042.c: d4 -> i8042 (command) [243] 

drivers/input/serio/i8042.c: ed -> i8042 (parameter) [243] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 0) [293] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [438] 

drivers/input/serio/i8042.c: 54 -> i8042 (parameter) [438] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [438] 

drivers/input/serio/i8042.c: 44 -> i8042 (parameter) [438]
serio: i8042 KBD port at 0x60,0x64 irq 1 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [486] 

drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [486] 

drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [486] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [488] 

drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [489] 

drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [490] 

drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [490] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [493] 

drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [493] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [496] 

drivers/input/serio/i8042.c: f3 -> i8042 (kbd-data) [496] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [498] 

drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [498] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [501] 

drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [501] 

drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [504] 

input: AT Translated Set 2 keyboard on isa0060/serio0

*Without keyboard* :

mice: PS/2 mouse device common for all mice 

drivers/input/serio/i8042.c: fa <- i8042 (flush, aux) [0] 

drivers/input/serio/i8042.c: 20 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 9a <- i8042 (return) [0] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 9a -> i8042 (parameter) [0] 

drivers/input/serio/i8042.c: d3 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [0] 

drivers/input/serio/i8042.c: a5 <- i8042 (return) [0] 

drivers/input/serio/i8042.c: a7 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: 20 -> i8042 (command) [0] 

drivers/input/serio/i8042.c: c7 <- i8042 (return) [0] 

Failed to disable AUX port, but continuing anyway... Is this a SiS?
If AUX port is really absent please use the 'i8042.noaux' option. 

drivers/input/serio/i8042.c: a8 -> i8042 (command) [155] 

drivers/input/serio/i8042.c: 20 -> i8042 (command) [155] 

drivers/input/serio/i8042.c: e7 <- i8042 (return) [155] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [155] 

drivers/input/serio/i8042.c: 8a -> i8042 (parameter) [155] 

serio: i8042 KBD port at 0x60,0x64 irq 1 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [203] 

drivers/input/serio/i8042.c: 8b -> i8042 (parameter) [203] 

drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [203] 

drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 1) [218] 

drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [218] 

drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 1) [232] 

drivers/input/serio/i8042.c: 60 -> i8042 (command) [232] 

drivers/input/serio/i8042.c: 8a -> i8042 (parameter) [232]

Anything there that says "don't reboot if there is no keyboard"?

Thankyou,
-- 
David N. Welton
davidw@eidetix.com
