Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUEJMOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUEJMOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbUEJMOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:14:38 -0400
Received: from postman2.arcor-online.net ([151.189.20.157]:13560 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S264655AbUEJMOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:14:34 -0400
Subject: Re: Re: psmouse.c - synaptics touchpad driver sync problem
From: Thorsten Hirsch <thorstenhirsch@arcor.de>
To: "linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1084191365.9101.21.camel@minime.hirsch.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 14:16:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,


> Could you please try the patch below - it changes the way we process
> interrupts from the keyboard controller.

Done. I used 2.6.6-mm1 (your patch succeeded), but there's still the same problem.
Well, at least I guess it's the same, because the errors in dmesg are looking different:

Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
Synaptics driver lost sync at byte 4
Synaptics driver lost sync at byte 1
Synaptics driver resynced.
[...]

> Also, in your dmesg, do you see
> messages like "psmouse.c: bad data from KBC - timeout"?

No. No timeout at all.
Here's the output of "dmesg | grep serio"...I just thought this might be helpful:

serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
input: SynPS/2 Synaptics TouchPad on isa0060/serio2
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0

Thorsten

P.S.: no need to CC me anymore, as I'm subscribed now to the lkml :-)
-- 
PGP public key:
http://home.arcor.de/thorstenhirsch/thirschatwebde.asc

