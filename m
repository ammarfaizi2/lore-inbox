Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUI1Qdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUI1Qdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 12:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUI1Qdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 12:33:33 -0400
Received: from bender.bawue.de ([193.7.176.20]:26329 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S267831AbUI1Qdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 12:33:31 -0400
Date: Tue, 28 Sep 2004 18:33:24 +0200
From: Joerg Sommrey <jo175@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: nmi watchdog failure on dual Athlon box
Message-ID: <20040928163324.GA5759@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo175@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just tried Ingo's "lockupcli" nmi watchdog test - it fails to unlock the
box.

boot-parm:
...nmi_watchdog=2...

dmesg:
...
testing NMI watchdog ... OK.
...

/proc/interrupts:
...
NMI:        115        103
...

So far everything looks fine.  But after running Ingo's "lockupcli" the
box is locked (surprise!) but there is no nmi watchdog killing anything.
The system gets rebooted from the w83627hf WDT after 60 s.

System:
Tyan Tiger MPX (S2466)
2 x Athlon MP 2000+
kernel 2.6.8.1

nmi_watchdog=1 has never worked for me (except 2.6.3-mm4).

I'm not really surprised at this test as I had a couple of lockups in
the past that were never resolved by the nmi watchdog.

Any ideas?

-jo

-- 
-rw-r--r--  1 jo users 63 2004-09-28 17:44 /home/jo/.signature
