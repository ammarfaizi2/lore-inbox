Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWGGTBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWGGTBa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWGGTBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:01:30 -0400
Received: from aun.it.uu.se ([130.238.12.36]:47608 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932257AbWGGTBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:01:30 -0400
Date: Fri, 7 Jul 2006 21:01:26 +0200 (MEST)
Message-Id: <200607071901.k67J1Q5s023842@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.18-rc1 broke resume from APM suspend on Latitude CPi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.18-rc1 broke resume from APM suspend (to RAM)
on my old Dell Latitude CPi laptop. At resume the disk
spins up and the screen gets lit, but there is no response
to the keyboard, not even sysrq. All other system activity
also appears to be halted.

I did the obvious test of reverting apm.c to the 2.6.17
version and fixing up the fallout from the TIF_POLLING_NRFLAG
changes, but it made no difference. So the problem must be
somewhere else.

/Mikael
