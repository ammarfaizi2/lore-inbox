Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269964AbTGQTzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270079AbTGQTzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:55:54 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:40935 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S269964AbTGQTzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:55:49 -0400
Date: Thu, 17 Jul 2003 22:10:39 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
Message-ID: <20030717201039.GC25759@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030717141847.GF7864@charite.de> <m38yqxf2ab.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m38yqxf2ab.fsf@lugabout.jhcloos.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James H. Cloos Jr. <cloos@jhcloos.com>:

> Ralf> atkbd.c: Unknown key (set 2, scancode 0xb2, on isa0060/serio0) pressed.
> Ralf> atkbd.c: Unknown key (set 2, scancode 0xae, on isa0060/serio0) pressed.
> Ralf> atkbd.c: Unknown key (set 2, scancode 0xb1, on isa0060/serio0) pressed.
> Ralf> atkbd.c: Unknown key (set 2, scancode 0x97, on isa0060/serio0) pressed.
> Ralf> atkbd.c: Unknown key (set 2, scancode 0xa2, on isa0060/serio0) pressed.
> Ralf> atkbd.c: Unknown key (set 2, scancode 0x92, on isa0060/serio0) pressed.
> 
> I've been hacking through a similar issue on some Dell laptops.
> 
> You need to add entries to the atkbd_set2_keycode[] array in
> drivers/input/keyboard/atkbd.h.  Look at the #defines in
> inlucde/linux/input.h for stuff that matches the keys that
> five the unknown key printk()s, and put those values in the
> Nth entry of the array, where N is the scancode reported in
> the printk().  
> 
> Eg, if the first key mentioned above were a VolumeUp key, you
> would want to add the value 115 to the 0xb2'th entry in the
> array.

But this happened while typing NORMALLY, with no frills :) I mean, I
was just typing in some unix commands - so I never even came close to
the keys I never use anyway...

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
