Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315174AbSEHVPV>; Wed, 8 May 2002 17:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315176AbSEHVPU>; Wed, 8 May 2002 17:15:20 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7106 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315174AbSEHVPU>;
	Wed, 8 May 2002 17:15:20 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 8 May 2002 23:14:48 +0200 (MEST)
Message-Id: <UTC200205082114.g48LEmw20256.aeb@smtp.cwi.nl>
To: quintela@mandrakesoft.com, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.14 IDE 56
Cc: aia21@cantab.net, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org, padraig@antefacto.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I'm more worried about the issue of "I installed RH-x.x, and then I
    upgraded the kernel, and now program xyz won't work any more", where "xyz"
    is something perfectly reasonable and common.

    For example, let's say that some strange version of "mount" _requires_
    /proc/ide to work (don't ask me why), and that Mandrake happened to ship
    that version in their 8.2 release, and if you use the new 2.5.15 kernel on
    that installation, it simply won't work. THAT would be a problem where
    some backwards compatibility crud is probably worth it.

First, beautiful things are happening to the IDE code. (*)
Insertion of backwards compatibility crud can be delayed
to just before 2.6 is released.

In the meantime, user space software can be fixed.

Second, no doubt some programs will be affected a little.
[For example, fdisk reads /proc/ide/%s/media and if that says
cdrom or tape it will skip the device. There are other similar,
non-essential, uses.]

Andries


(*) Last time I reported (i) immediate death at boot, and
(ii) HPT366 problems. Now that (i) has been fixed, let me
mention that (ii) has not been fixed yet. Disks hanging off
a HPT366 work well under 2.4.17 but kill the system
(with an infinite stream of "lost interrupt"s or so)
under 2.5.13. Maybe not immediately, but within a few hours.
Bad disk corruption has also been observed.

