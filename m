Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264416AbTDPOgT (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTDPOgT 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:36:19 -0400
Received: from smtp02.wxs.nl ([195.121.6.54]:19427 "EHLO smtp02.wxs.nl")
	by vger.kernel.org with ESMTP id S264416AbTDPOgS 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:36:18 -0400
Date: Wed, 16 Apr 2003 16:50:54 +0200 (CEST)
From: Ferry van Steen <freaky@www.bananateam.nl>
Subject: Compilation problems
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.33.0304161633470.1131-100000@www.bananateam.nl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bring this here, I know it's not the most correct place, but I
wouldn't know where else to find people that know this (I've asked in
several places)

First off, I have 2 computers a notebook with a P3, gentoo 1.4rc2 stage 1
and a athlon xp workstation with gentoo 1.4rc2. The workstation has an IDE
controller for which partially open-source drivers are available.

At this moment I have 2 disks for linux in the workstation, one on the
normal ide controller cause I couldn't get the RAID one to work and one on
the RAID. As you might understand I want to loose the one on the normal
IDE controller. Therefore, I started compiling on the notebook.

Both computers have gentoo from stage 1, all applications/libraries are
thus fully optimized for the CPU they run on.

Now when I compile a 2.4.20 kernel on either of them, with the athlon CPU
selected in the kernel config these run, no matter if it was compiled on
the notebook or the workstation, they run fine on the workstation.
However, if I compile the module on the notebook, against the sources of
the kernel that was compiled for the workstation and -march=athlon (just
like the kernel) this module will give unresolved symbols errors. If
however I compile this module on the athlon it runs without a problem.

I don't know a whole lot about the lower level things of compilation like
linkage, but what I think is that maybe part of the c libraries that have
already been compiled are transferred (linked with) the module and that
this P3 optimized code causes problems. This however are mere assumptions
and raises questions like why isn't the kernel bothered by this? And AFAIK
all P3 options should be supported on an Athlon-XP (that is /proc/cpuinfo
has all the flags my p3 has as well).

Any ideas what might cause this behaviour?

Kind regards

