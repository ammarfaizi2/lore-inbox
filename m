Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbTHLKRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 06:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269602AbTHLKRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 06:17:44 -0400
Received: from post.tau.ac.il ([132.66.16.11]:60054 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S269578AbTHLKRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 06:17:43 -0400
Subject: halt/resume broke under acpi (2.4.21)
From: Micha Feigin <michf@math.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060683549.1539.35.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 12 Aug 2003 13:19:10 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.21.0.0; VDF: 6.21.0.11; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point (can't say exactly when) my laptop started locking up with
acpi support.
When I try to halt the computer reaches the power down message and locks
(sometimes it goes the extra step to the blank screen with backlight
still on).
Reboot manages to reboot the computer, but then it shows the bios'
welcome screen turns on the HD led and locks.

Windows manages to halt and reboot properly, so I am guessing its not a
problem with the laptop. Also echo 5 > /proc/acpi/sleep turn the
computer off properly.

When changing in drivers/acpi/sleep.c under the function acpi_power_off
the sleep state from S5 to S4, halt started working again, but I don't
think that that is the solution. (This with acpi patched kernel, worked
the same for the matching function for the unpatched kernel).
apm halts the computer properly but doesn't reboot.
Any ideas as for solutions, how to debug the problem, or where I can
find some documentation in this task to know a bit more what I am
looking for?
Would this be a kernel bug or hardware bug?

I tried using a modified dsdt table and the original one but no
difference, and also a different version of the suspend/halt/shutdown
functions.

I am using linux debian unstable with the debian 2.4.21 kernel on a sony
vaio fxa-53 (athelon xp/via) laptop.

