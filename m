Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130691AbQKHJ0C>; Wed, 8 Nov 2000 04:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130700AbQKHJZw>; Wed, 8 Nov 2000 04:25:52 -0500
Received: from widukind.bi.teuto.net ([212.8.197.28]:6411 "EHLO
	widukind.bi.teuto.net") by vger.kernel.org with ESMTP
	id <S130691AbQKHJZf>; Wed, 8 Nov 2000 04:25:35 -0500
Date: Wed, 8 Nov 2000 10:24:56 +0100
From: Michael Westermann <mw@microdata-pos.de>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: i386 PC Keyboad Patch, for very exotic Keyboads 
Message-ID: <20001108102456.A26847@microdata-pos.de>
Mail-Followup-To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

ich have wrote a Patch, for all the PS2-Keyboards what
use exotic Scancodes and Functions. Teh backgroud is 
that we use Point of Sale Keyboards with Display , Keylock
ans Magnetic Stripe Reader. On Keyboard send the Magnetic-Tracks 
in a Raw Format only as Scacodes. I can't handle this data in the 
user-space with the RAW Mode. The Original Keyboard Driver Can't 
handle this, the stati for Caps and Shift ar all false, after this.
An other Problem ist that the orignal PS/2 Driver can't write data
to the Keyboard for example an Keyboard with an Keylock. I must 
write a Command to the Keyboard, that than replay my the Keylock-
position.

The Idee is that an Driver-module can registrated one 
keyboard-event-extention. with the Funktion. 

register_kbd_ex
unregister_kbd_ex 

This Funktion can tah filtered the Exotic Scanodes. 

I think this Patch  is veriy interst for Keyboard'with additional 
Key-Funktions for example Keys for a  CD-Player. The additional 
Keys can filtered in a Modular-Driver, wich used from the CD-Player.

My patch is written for a 2.2.16 Kernel, i think it is no Probem 
use the Patch for an other  2.2.* kernel, with a litte bit change
for the 2.4.x kernel.

Please give me Comments

Michael Westermann

PS: We have installed over 10 Supermarket with Debian/Linux POS-Systemen ;-) 


 





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
