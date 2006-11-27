Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935711AbWK1InR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935711AbWK1InR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935692AbWK1Imz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:42:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47547 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935704AbWK1Imm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:42:42 -0500
Date: Mon, 27 Nov 2006 10:49:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Karsten Wiese <fzu@wemgehoertderstaat.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: 2.6.19-rc6-rt8
Message-ID: <20061127094927.GA7339@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00,DATE_IN_PAST_12_24 autolearn=no SpamAssassin version=3.0.3
	0.7 DATE_IN_PAST_12_24     Date: is 12 to 24 hours before Received: date
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.19-rc6-rt8 tree, which can be downloaded from 
the usual place:

    http://redhat.com/~mingo/realtime-preempt/

lots of fixes are included in -rt8. In particular the inode/dentry leak 
found and fixed by Karsten Wiese (and the related OOMs reported by 
others) should be fixed.

I also started tracking Linus' latest -git tree, so all upstream 
stabilization fixes since -rc6 are included in -rt8 as well.

[ the latest KVM patchqueue is now included in -rt too. KVM should not
  impact anyone unless enabled. The YUM rpms have KVM enabled on both
  i686 and x86_64. ]

to build a 2.6.19-rc6-rt8 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.19-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.19-rc6-rt8

the -rt YUM repository for Fedora Core 6 and 5, for architectures x86_64 
and i686 can be activated via:

   cd /etc/yum.repos.d
   wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo

   yum install kernel-rt.x86_64   # on x86_64
   yum install kernel-rt          # on i686

   yum update kernel-rt           # refresh - or enable yum-updatesd

as usual, bugreports, fixes and suggestions are welcome,

	Ingo
