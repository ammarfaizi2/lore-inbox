Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130971AbRCFPik>; Tue, 6 Mar 2001 10:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130977AbRCFPia>; Tue, 6 Mar 2001 10:38:30 -0500
Received: from rhinocomputing.com ([161.58.241.147]:32271 "EHLO
	rhinocomputing.com") by vger.kernel.org with ESMTP
	id <S130971AbRCFPiQ>; Tue, 6 Mar 2001 10:38:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15013.1126.621871.683720@rhino.thrillseeker.net>
Date: Tue, 6 Mar 2001 10:38:14 -0500
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-thinkpad@www.bm-soft.com
Subject: -ac11 sound card, anacron, suspend errors on Thinkpad A20p
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using -ac11 (otherwise stable) I've noticed the following sound
card messages when unplugging or plugging in my Thinkpad:

Mar  6 09:53:17 localhost kernel: cs461x: AC'97 read problem (ACSTS_VSTS), reg = 0x1a
Mar  6 09:53:17 localhost kernel: cs461x: AC'97 read problem (ACSTS_VSTS), reg = 0x1a
Mar  6 09:53:18 localhost apmd[194]: Now using Battery Power
Mar  6 09:53:18 localhost kernel: cs461x: AC'97 read problem (ACSTS_VSTS), reg = 0x1a
Mar  6 09:53:32 localhost last message repeated 10 times
Mar  6 09:53:32 localhost apmd[194]: Now using AC Power
Mar  6 09:53:32 localhost apmd[194]: Charge: * * * (99% 1:59)
Mar  6 09:53:32 localhost anacron[20263]: Anacron 2.3 started on 2001-03-06
Mar  6 09:53:32 localhost anacron[20263]: Normal exit (0 jobs run)
Mar  6 09:53:32 localhost kernel: cs461x: AC'97 read problem (ACSTS_VSTS), reg = 0x1a
Mar  6 09:55:16 localhost last message repeated 64 times
Mar  6 09:55:23 localhost last message repeated 17 times
Mar  6 09:55:25 localhost apmd[194]: Now using Battery Power
Mar  6 09:55:25 localhost apmd[194]: Battery: * * * (99% unknown)
Mar  6 09:55:26 localhost kernel: cs461x: AC'97 read problem (ACSTS_VSTS), reg = 0x1a
Mar  6 09:55:28 localhost last message repeated 5 times
Mar  6 09:55:29 localhost apmd[194]: Now using AC Power
Mar  6 09:55:29 localhost apmd[194]: Charge: * * * (99% unknown)
Mar  6 09:55:29 localhost anacron[20333]: Anacron 2.3 started on 2001-03-06
Mar  6 09:55:29 localhost anacron[20333]: Normal exit (0 jobs run)
Mar  6 09:55:29 localhost kernel: cs461x: AC'97 read problem (ACSTS_VSTS), reg = 0x1a

The Anacron restart was curious, but I haven't noticed either of these
messages previously.  The "buttons" on TKMixer would cycle as if being
activated after this event too.  Restarting TKMixer solves both the
cycling problem and the sound messages.  This is repeatable, and the
AC'97 message doesn't occur if TKMixer isn't running.  The
Anacron message occurs with or without TKMixer's involvment.

Suspend has not worked for quite a while in the 2.4 kernel series (I
can't remember when it last did, but it *did*).  Anyone have a
APM/ACPI configuration for the 2.4 that seems to work?

Billy
