Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbTBKQvz>; Tue, 11 Feb 2003 11:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbTBKQvz>; Tue, 11 Feb 2003 11:51:55 -0500
Received: from sark.cc.gatech.edu ([130.207.7.23]:59546 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S267488AbTBKQvy>; Tue, 11 Feb 2003 11:51:54 -0500
Date: Tue, 11 Feb 2003 12:01:38 -0500 (EST)
From: James Gibson Fusia <visyz@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
cc: visyz@cc.gatech.edu
Subject: Keyboard Writing
Message-ID: <Pine.GSO.4.50.0302111142060.53-100000@oscar.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've read through the keyboard driver files (kd.h, keyboard*, pc_keyb*),
and come to the conclusion that you can't write to the keyboard. Get mode,
set mode, get leds, set leds, change keymap. But no write to keyboard.

I need to be able to re-program a keyboard from userspace, and this
involves sending certain keycodes to the keyboard via port manipulation
(set write bit, write, wait for write bit clear.. blah blah blah), and no
manipulation handles.

My question to you, then, is how do I add definitions for ioctl to be able
to write to the ps/2 keyboard from user-space? (the #defs for
KD(GET|SET)LED seem to be arbitrary and not related to 0x64).

Essentially, I would like to be able to treat the keyboard like a serial
port. Any docs you can point me at? (Yes, I've checked everything google
showed me and none of it seemed pertinent to physically writing to the
keyboard.)

Please respond directly to me, as I'm a bum and don't want to join the
kernel-dev list.
			-James Gibson Fusia (visyz@cc.gatech.edu)
