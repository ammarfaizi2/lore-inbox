Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265673AbSJSTea>; Sat, 19 Oct 2002 15:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265674AbSJSTea>; Sat, 19 Oct 2002 15:34:30 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36359 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265673AbSJSTea>; Sat, 19 Oct 2002 15:34:30 -0400
Date: Sat, 19 Oct 2002 15:40:22 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Any hope of fixing shutdown power off for SMP?
Message-ID: <Pine.LNX.3.96.1021019152828.29078L-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've beaten this dead horse before, but it still irks me that Linux can't
power down an SMP system. People claim that it can't be done safely, but
maybe somone can reverse engineer NT if we aren't up to the job.

Every once in a while a power fail will leave the systems on UPS, and at
some point it's needed to shut them down before the UPS is dead. You don't
want that, since if the power comes up and then drops during boot it may
hose filesystems. So I want the system really down while the UPS has a
fair bit of power left.

The only suggestion I got was to install NT, put a powerdown in the
startup directory, use lilo -R to reboot in NT, then do a reboot. 
Wonderful. What I'm actually doing is rebooting a UP kernel and checking
in rc.local for only one processor, in which case I power down. That
works, but it's ugly! 

Is it really that hard to shutdown all CPUs but one, then power down?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

