Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbULPPmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbULPPmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbULPPmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:42:50 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:35589 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261186AbULPPms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:42:48 -0500
Date: Thu, 16 Dec 2004 15:42:44 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
In-Reply-To: <20041216151126.GA17066@elte.hu>
Message-ID: <Pine.LNX.4.58L.0412161537030.15472@blysk.ds.pg.gda.pl>
References: <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random>
 <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu>
 <20041214224706.GA26853@elte.hu> <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
 <1103157476.3585.33.camel@localhost.localdomain> <Pine.LNX.4.58.0412151756550.3279@ppc970.osdl.org>
 <20041216145159.GA3204@elte.hu> <Pine.LNX.4.58L.0412161501190.15472@blysk.ds.pg.gda.pl>
 <20041216151126.GA17066@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Ingo Molnar wrote:

> The 'sti' "shadows" the cli, i.e. we'll never get an interrupt that gets
> inbetween 'sti;cli'. I.e. sti is the black-hole generator, and 'cli' is
> in the black hole. In that sense the 'cli' is in a black hole to the
> NMI: the NMI will never see cli as the 'next to be executed'
> instruction.

 That's what I meant indeed, but I'd like to emphasise, for readers to be
aware, the black hole is not tied to the 'cli' instruction itself in any
way.  The black-holed instruction needs not be a 'cli' -- it can be an
arbitrary one except from ones creating black holes as you've observed
with your test.

  Maciej
