Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbTAOKNS>; Wed, 15 Jan 2003 05:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTAOKNS>; Wed, 15 Jan 2003 05:13:18 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:31708 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266100AbTAOKNR>;
	Wed, 15 Jan 2003 05:13:17 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15909.13901.284523.220804@harpo.it.uu.se>
Date: Wed, 15 Jan 2003 11:22:05 +0100
To: voytech@ucw.cz
Subject: Dell Latitude CPi keyboard problems since 2.5.42
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

On October 17, I wrote to LKML:
>Dell Latitude CPi laptop. Boot 2.5.42 or .43, then reboot.
>Shortly after the screen is blanked and the BIOS starts, it
>prints a "keyboard error" message and requests an F1 or F2
>response (continue or go into SETUP). Never happened with any
>other kernel on that machine.

(see http://marc.theaimsgroup.com/?t=103484432100001&r=1&w=2
for the full thread)

This problem is still present in 2.5.58. Any ideas what might
be causing it? I've tried a few obvious tweaks (forcing
atkbd_reset=1, making atkbd_cleanup() do nothing), but none
has helped.

Kernel 2.5.41 and older, and current 2.4/2.2 kernels, don't
cause this problem, so obviously the input driver must be doing
_something_ the HW or BIOS doesn't like.

I have CONFIG_{SERIO_I8042,KEYBOARD_ATKBD,INPUT_MOUSEDEV_PSAUX,
MOUSE_PS2,INPUT_PCSKR} enabled.

/Mikael
