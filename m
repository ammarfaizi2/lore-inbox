Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132859AbRDXWTQ>; Tue, 24 Apr 2001 18:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132892AbRDXWTH>; Tue, 24 Apr 2001 18:19:07 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:37892 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S132859AbRDXWSt>; Tue, 24 Apr 2001 18:18:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Compiled sound causes loss of scrollback console : 2.4.4-p6
Reply-To: klink@clouddancer.com
Message-Id: <20010424221843.7F6006808@mail.clouddancer.com>
Date: Tue, 24 Apr 2001 15:18:43 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While tracking down a sound problem, I decided to compile in the
soundblaster rather than use modules.  It's been a long time since I
ran sound under linux, but that used to work fine.

I watched the reboot, noticed the usual isapnp stuff (part of problem)

...
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative SB16 PnP'
isapnp: 1 Plug & Play card detected total
...

and then noticed that there were no soundblaster messages and tried to
scrollback to verify.  Pressing Shift-PageUp did absolutely nothing.

The only change was to move from modules to compiled for sound, OSS,
and soundblaster.  Booting the previous kernel(s) showed a working
scrollback.  2.4.4-pre6 compiled under gcc 2.95.3 20010315 release.
