Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTI2VfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTI2VfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:35:09 -0400
Received: from gprs144-48.eurotel.cz ([160.218.144.48]:29828 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262796AbTI2VfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:35:02 -0400
Date: Mon, 29 Sep 2003 23:34:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pm: Revert swsusp to 2.6.0-test3
Message-ID: <20030929213446.GF1815@elf.ucw.cz>
References: <20030928100620.5FAA63450F@smtp-out2.iol.cz> <Pine.LNX.4.44.0309281038270.6307-100000@home.osdl.org> <20030928175853.GF359@elf.ucw.cz> <20030929204634.GA2425@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929204634.GA2425@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'd also like to have some kind of readme or similar on the different 
> > > suspend/resume issues, and why we have two different
> > > approaches. Hmm?
> 
> <azbestos underwear on>What about this one?</off>

Thanks to Tomas Szepe, grammar fixed a bit.

--- clean/Documentation/power/swsusp.txt	2003-08-27 12:00:01.000000000 +0200
+++ linux/Documentation/power/swsusp.txt	2003-09-29 23:29:43.000000000 +0200
@@ -17,6 +17,24 @@
 You need to append resume=/dev/your_swap_partition to kernel command
 line. Then you suspend by echo 4 > /proc/acpi/sleep.
 
+Pavel's unreliable guide to swsusp mess
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
+
+They are currently two versions of swap suspend in the kernel, the old
+"Pavel's" version in kernel/power/swsusp.c and the new "Patrick's"
+version in kernel/power/pmdisk.c. They provide the same functionality;
+the old version looks ugly but was tested, while the new version looks
+nicer but did not receive so much testing. echo 4 > /proc/acpi/sleep
+calls the old version, echo disk > /sys/power/state calls the new one.
+
+[In the future, when the new version is stable enough, two things can
+happen:
+
+* the new version is moved into swsusp.c, and swsusp is renamed to swap
+  suspend (Pavel prefers this)
+
+* pmdisk is kept as is and swsusp.c is removed from the kernel]
+
 [Notice. Rest docs is pretty outdated (see date!) It should be safe to
 use swsusp on ext3/reiserfs these days.]
 


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
