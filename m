Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVCPNmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVCPNmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVCPNmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:42:33 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38077 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262582AbVCPNmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:42:18 -0500
Date: Wed, 16 Mar 2005 14:41:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050316134150.GA24970@elte.hu>
References: <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu> <20050315130046.GK7699@opteron.random> <20050315150526.GA14744@elte.hu> <20050315164420.GT7699@opteron.random> <20050316082851.GB10260@elte.hu> <20050316104618.GB11192@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316104618.GB11192@opteron.random>
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


* Andrea Arcangeli <andrea@cpushare.com> wrote:

> > obviously the irq and sys_read/sys_write code is way too complex to be
> > mathematically provable in the near future.
> 
> Math provable is irrelevant with real software world since nobody has
> enough resources to demonstrate math correctness.

(this is becoming tangential, but i'd not be as brave to suggest that
formal provability of real software is irrelevant. It's not feasible
today and probably not feasible in the near future. What tomorrow brings
we cannot know.)

> > sorry, but if an attacker can cause arbitrary signals to be sent to your
> > secure application (and the signals pass the security checks!) then you
> > have much bigger problems!
> 
> It's not the attacker that sends the signal! It's a buggy application
> coming from the CDs, like a videogame hitting a bug.

well, for an attack to become possible, it's the attacker that has to be
able to trigger it. By your logic i could say: 'many people use empty
passwords for root, so it could easily happen that a seccomp box gets
compromised that way'. The fact that sending SIGCONT to the seccomp
application _seems_ to be more related to the security of the ptrace
solution does not make it any more relevant in reality than the root
password issue. (But i guess after many years i should be wiser not to
get into such arguments with you.) And i've yet to see applications
sending spurious SIGCONT's to each other 'by accident'.

OTOH, i accept your point that a 'no way back' kernel-enforced kind of
sandbox (which seccomp provides and ptrace doesnt) is a useful concept.

	Ingo
