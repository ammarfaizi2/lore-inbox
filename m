Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUDUONP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUDUONP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUDUONP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:13:15 -0400
Received: from main.gmane.org ([80.91.224.249]:4003 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262794AbUDUONM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:13:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [PATCH 6/15] New set of input patches: atkbd soften accusation
Date: Wed, 21 Apr 2004 16:13:00 +0200
Message-ID: <MPG.1af09f787ecab63989697@news.gmane.org>
References: <200404210049.17139.dtor_core@ameritech.net> <200404210054.23583.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-107-142.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> +				printk(KERN_WARNING "atkbd.c: Unknown key %s "
> +				       "(%s set %d, code %#x on %s).\n",
> +				       atkbd->release ? "released" : "pressed",
> +				       atkbd->translated ? "translated" : "raw",
> +				       atkbd->set, code, serio->phys);
> +				printk(KERN_WARNING "atkbd.c: Use 'setkeycodes %s%02x <keycode>' "
> +				       "to make it known.\n",
> +				       code & 0x80 ? "e0" : "", code & 0x7f);

By the way, until the atkbd.c / keyboard.c interaction is fixed, using setkeycodes might 
*not* make the keys known *properly*. (example: try setkeycodes e001 129: you'll notice 
that a key whose raw code is 0x81 will not produce keycode 129, because the raw mode 
emulation will actually turn the 0x81 in a 0x85.)

(See also the temporary patch I posted recently).

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

