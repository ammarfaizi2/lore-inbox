Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266097AbUGENrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUGENrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 09:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUGENre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 09:47:34 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:25614 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266097AbUGENrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 09:47:24 -0400
Date: Mon, 5 Jul 2004 15:47:23 +0200
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Synaptics not working with 2.6.7-mm6 (usb fixed)
Message-ID: <20040705134723.GA17146@gamma.logic.tuwien.ac.at>
References: <20040705131002.GA14768@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040705131002.GA14768@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi list!

As a follow up to the previous email concerning deadlocks with -mm6 here
a more detailed description concerning the synaptics device not being
found:

Here is the relevant part of the dmesg output with -mm6:
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1

and here with a working -mm5:
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1


THe only difference I have between mm5 and mm6 is that I disabled
framebuffer and made *all* usb modular (before the hci and some more
were compiled in -- I am testing S2R).

Do you have any idea what might have done this?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
ALBUQUERQUE (n.)
A shapeless squiggle which is utterly unlike your normal signature,
but which is, nevertheless, all you are able to produce when asked
formally to identify yourself. Muslims, whose religion forbids the
making of graven images, use albuquerques to decorate their towels,
menu cards and pyjamas.
			--- Douglas Adams, The Meaning of Liff
