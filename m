Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWAMMnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWAMMnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 07:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWAMMnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 07:43:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:61346 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1422649AbWAMMnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 07:43:52 -0500
Date: Fri, 13 Jan 2006 13:44:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org
Subject: [patch 00/62] sem2mutex: -V1
Message-ID: <20060113124402.GA7351@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch-queue converts 66% of all semaphore users in 2.6.15-git9 to 
mutexes.

The conversion was done by Arjan van de Ven, Jes Sorensen and myself, 
via automatic tools, and the result was verified automatically as well.  
Only minimal manual editing was done. We only converted semaphores that 
are used as mutexes. The known "is not a mutex" list of semaphores
collected in the -rt tree in past year was automatically added to the
do-not-convert list as well. We also reviewed the resulting changes
manually, and did testbuilds and test-boots.

the GIT tree can be pulled from:

  master.kernel.org/pub/scm/linux/kernel/git/mingo/mutex-2.6.git/

or:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/mingo/mutex-2.6.git/

(once master has resynced)

the patch-queue can also be downloaded from:

  http://redhat.com/~mingo/generic-mutex-subsystem/

and a 'combo' patch is at:

  http://redhat.com/~mingo/generic-mutex-subsystem/combo.patch

which is useful to people who'd like to test the whole patchqueue at 
once.

the patch-queue has been build-tested with allyesconfig, and booted on 4 
separate x86 systems.

	Ingo
