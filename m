Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUIGL5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUIGL5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 07:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUIGL4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 07:56:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17104 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267916AbUIGL4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 07:56:00 -0400
Date: Tue, 7 Sep 2004 13:57:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk12-R8
Message-ID: <20040907115722.GA10373@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907092659.GA17677@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


test-booted the x64 kernel and found a number of bugs in the x64 port of
the VP patch. I've uploaded -R8 that fixes them:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R8

NOTE: i tested a (non-modular) 64-bit bzImage on a 32-bit OS (FC2) but
havent booted it on a 64-bit userland yet. But i'd expect 64-bit
userspace to work just fine too.

to get a 2.6.9-rc1-bk12 kernel the patching order is:

    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
  + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc1.bz2
  + http://redhat.com/~mingo/voluntary-preempt/patch-2.6.9-rc1-bk12.bz2 

	Ingo
