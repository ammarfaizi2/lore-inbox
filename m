Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270955AbTGPQnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270957AbTGPQnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:43:16 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:32145 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S270955AbTGPQnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:43:03 -0400
Date: Wed, 16 Jul 2003 17:57:02 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: axboe@suse.de, vojtech@suse.cz
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716165701.GA21896@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, axboe@suse.de,
	vojtech@suse.cz, Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've decided to oggify my CD collection, and every now and
again, the mouse pointer goes bezerk is if I had been
shaking it around and randomly clicking on things.
In the logs are lots of..

psmouse.c: Lost synchronization, throwing 3 bytes away.

It only happens whilst cdparanoia is reading from the CD.
The IDE CD drive is using DMA, and interrupts are unmasked.
according to the logs, its happened 32 times since I last
booted..  /proc/interrupts shows that the i8042 is using
a different interrupt to the IDE devices..

Mouse is a logitech wheely PS/2 mouse, using ImPS/2 protocol
in X config reading from /dev/psaux.

This is using 2.6test1, I'don't recall ever seeing this
happen in 2.4, but it did occur for a while earlier in 2.5,
and I forgot about it until now.

Any ideas?

		Dave

