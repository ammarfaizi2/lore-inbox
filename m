Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSAaB1A>; Wed, 30 Jan 2002 20:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290812AbSAaB0m>; Wed, 30 Jan 2002 20:26:42 -0500
Received: from mackman.submm.caltech.edu ([131.215.85.46]:49283 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S290805AbSAaBZA>;
	Wed, 30 Jan 2002 20:25:00 -0500
Date: Wed, 30 Jan 2002 17:24:59 -0800 (PST)
From: Ryan Mack <rmack@mackman.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] dmesg: "invalidate: busy buffer"
Message-ID: <Pine.LNX.4.44.0201301717340.9601-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last two days my dmesg buffer has be filled with "invalidate: busy
buffer" messages.  I tried rebooting (and forcing a fsck), but after about
12 hours they came back.

I'm running 2.4.17 on a dual P3, Intel 440BX chipset.  Both filesystems
are raid mirrored, ext3, ordered-data mode.  One mirrored pair is on a
Adaptec AHA-2940U2/W controller (actually, this is running in degraded
mode, damn defective IBM UltraStar failed on me).  The other mirrored pair
is on two Intel PIIX4 IDE controllers.

Since one of the raid pairs is down to a single drive, I've been backing
it up to the other mirrored pair nightly using dump 0.4b22 and, more
recently, dump 0.4b26.

Any thoughts what's causing this?  Am I at risk for data loss?

-Ryan Mack

