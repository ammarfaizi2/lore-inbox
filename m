Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263578AbUEHLsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUEHLsz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 07:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbUEHLsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 07:48:55 -0400
Received: from smtp07.web.de ([217.72.192.225]:32388 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263578AbUEHLsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 07:48:53 -0400
Subject: psmouse.c - synaptics touchpad driver sync problem
From: Thorsten Hirsch <t.hirsch@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1084016929.8558.16.camel@minime.hirsch.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 08 May 2004 13:48:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm having some sync trouble with kernel 2.6.6-rc3-mm1 (and older 2.6
kernels) in combination with Peter Osterlund's synaptics driver:

psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.

...and so on. This is causing my mouse in X11 to hang, especially when
cpu load is high. The mouse pointer is doing an uncontrollable move and
some other things are hanging for a short moment, too: xmms for example.
(I guess the whole system is hanging, but xmms playing some music is
very easy to monitor)

I'm using the latest synaptics driver (0.13.0) and I've also tried
0.12.5. I wrote a mail to Peter, but he said, that I should write to the
lkml, so here I am. :-)
X11 version is X.org 6.7.0...but I think, that this doesn't matter. I
even had the same problem with XFree86 4.3.0.

Btw, there's no problem when I use standard ps/2 driver in X, but well,
I'm really missing the synaptics features then.

Regards,
Thorsten

P.S.: I'm not subscribed to the lkml, so please CC me in your answer!

