Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318197AbSGQCou>; Tue, 16 Jul 2002 22:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318199AbSGQCou>; Tue, 16 Jul 2002 22:44:50 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:27949 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S318197AbSGQCot>; Tue, 16 Jul 2002 22:44:49 -0400
Date: Wed, 17 Jul 2002 12:51:49 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-sound@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Ali5451 and MIDI synth
Message-ID: <Pine.LNX.4.05.10207171247410.1649-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to get MIDI synth happening with the Ali M5451 audio chipset
(as found in the Toshiba 1800 notebook).

So far, it appears to me that:

* linux-2.2 has MIDI support in the code (v0.14.5c of trident.c) - but
this driver (a) doesn't work for basic audio[1] and (b) doesn't register a
MIDI synth device (and MIDI players complain of no device).

* linux-2.4 has no MIDI support in the code (v0.14.9d of trident.c) - this
driver works OK for basic audio.  Oddly, I can't see any mention of the
MIDI code removal in the driver's history.

* ALSA-0.9 - no MIDI support in the code (alsa-kernel/pci/ali5451/*).

Have I missed something here?

Thanks,
Neale.

[1] "doesn't work for basic audio" includes this being logged to kern.log:

	trident: drain_dac, dma timeout?

Interestingly, I can make this go away by first loading and unloading the
ALSA drivers then loading the OSS drivers.  This makes me suspicious that
linux-2.2's OSS driver is missing something in the initialisation.


