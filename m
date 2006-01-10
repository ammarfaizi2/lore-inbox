Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWAJANs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWAJANs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWAJANs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:13:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:11755 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751722AbWAJANs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:13:48 -0500
Date: Tue, 10 Jan 2006 01:13:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [GIT PATCHES] mutex subsystem, -V16
Message-ID: <20060110001356.GA16122@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is the latest version of the generic mutex subsystem, against 
Linus-curr. The GIT tree can be pulled from:

  master.kernel.org:/pub/scm/linux/kernel/git/mingo/mutex-2.6.git/

or:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/mingo/mutex-2.6.git/

(once master has resynced)

or the patch-queue can be downloaded from:

  http://redhat.com/~mingo/generic-mutex-subsystem/

this code is identical to the mutex code in 2.6.15-mm2. There's been 
little changes since -V15:

 - added the extra smp_mb()s to the generic headers, pointed out by 
   Linus.

 - finished the i_mutex conversion.

 - fixed the ALSA i_mutex related bug that the mutex debugging code 
   uncovered in -mm2 (part of the i_mutex conversion patch).

 - dropped the small-misc-conversions patch, will go through 
   maintainers, if the mutex core is upstream.

	Ingo
