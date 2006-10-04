Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWJDRhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWJDRhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbWJDRhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:37:48 -0400
Received: from www.osadl.org ([213.239.205.134]:62948 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161149AbWJDRhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:37:47 -0400
Message-Id: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:29 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 00/22] high resolution timers / dynamic ticks - V3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

this is an updated replacement queue against -mm3 , with all the
fixlets backmerged to the appropriate places (Build-fix-from: added).

The queue contains further:

- accounting weirdness fixup, which solves Valdis problem
- command line option to disable high resolution mode on boot
- resolution config option removed
- TSC marked unusable for high resolution mode, due to circular
  dependency problems
- Comments for the secret PIT fix :)

The broken out series is available at the usual place:
http://www.tglx.de/projects/hrtimers/2.6.18-mm3

	tglx

--

