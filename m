Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268533AbUJDVzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268533AbUJDVzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUJDVww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:52:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43997 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268533AbUJDVvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:51:43 -0400
Date: Mon, 4 Oct 2004 23:53:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, thewade <pdman@aproximation.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
Message-ID: <20041004215315.GA17707@elte.hu>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041003210926.GA1267@elte.hu>
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


i've released the -S9 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9

Changes since -S8:

 - merge to -mm2. mm2 includes another latency breaker: Hugh Dickins'
   vmtruncate rework that should fix the bash-shared-mapping latency.

 - fix the x64 compilation bug reported by thewade

 - fix the menuconfig duplicate entry bug noticed by Florian Schmidt

 - (fix two preempt bugs in -mm2 - will be in -mm3)

to build an -S9 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc3.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/2.6.9-rc3-mm2.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9

	Ingo
