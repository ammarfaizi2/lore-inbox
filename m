Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268758AbUIGW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268758AbUIGW4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268752AbUIGWze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:55:34 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19122 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268751AbUIGWzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:55:12 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, rncbc@rnbnc.org
In-Reply-To: <20040905140249.GA23502@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu>  <20040905140249.GA23502@elte.hu>
Content-Type: text/plain
Message-Id: <1094597710.16954.207.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Sep 2004 18:55:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-05 at 10:02, Ingo Molnar wrote:
> i've released -R5:
>  
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R5

Ingo, here is a report from a user (Rui) of a problem that seems to have
been introduced in Q5.  The symptoms look very similar to the SMP/HT
problems that were thought to be fixed.  I have already requested more
info as to what happens if soft/hardirq preemption are enabled.

---

I'm having some trouble with latest VP patches on my P4 HT/SMP box. The
trouble is that since Q5 that I can't get my machine to boot reliably,
if at all. It goes almost all through the init scripts to drop dead on
the beach, so to speak. It just freezes completely somewhere before the
login prompts.

This only happens if the kernel is configured for SMP/SMT
(HyperThreading). The very same kernel configured and built for UP boots
and runs fine. As I said before this was introduced on the Q5 patch, and
the same showstopper is present on latest R6. Only with Q3 I'm still
happy, altought only with softirq-preempt=0 AND hardirq-preempt=0.

The "offending" box is a SUSE 9.1 based one, P4 2.80C HT on a ASUS
P4P800 mobo, 1GB DDR.

---

Lee

