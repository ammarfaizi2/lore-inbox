Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269626AbUICLeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269626AbUICLeo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269627AbUICLen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:34:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25507 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269626AbUICLel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:34:41 -0400
Date: Fri, 3 Sep 2004 13:36:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Free Ekanayaka <free@agnula.org>, Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it,
       Lee Revell <rlrevell@joe-job.com>
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-R2
Message-ID: <20040903113600.GA29108@elte.hu>
References: <1094171082.19760.7.camel@krustophenia.net> <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net> <20040903070500.GB13100@elte.hu> <1094197233.19760.115.camel@krustophenia.net> <87acw7bxkh.fsf@agnula.org> <1094198755.19760.133.camel@krustophenia.net> <20040903092547.GA18594@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903092547.GA18594@elte.hu>
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


i've uploaded -R2:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R2

no function changes, only fixing some rough edges: it fixes an UP
boot-time assert that occurs right after 'checking hlt'. I also fixed
PREEMPT_TIMING + !LATENCY_TRACE build bugs, and another boot bug that
occurs when PREEMPT_TIMING + !FRAME_POINTERS is used.

(the reboot assert i'm not sure about - tried to reproduce but here
reboot works fine. Will need some sort of serial log to debug this.)

	Ingo
