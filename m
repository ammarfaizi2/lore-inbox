Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbULPO3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbULPO3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbULPO2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:28:40 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:13442 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262678AbULPO1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:27:49 -0500
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <Pine.LNX.4.61.0412151909110.5038@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com>
	 <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com>
	 <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
	 <41BC0854.4010503@colorfullife.com>
	 <20041212093714.GL16322@dualathlon.random>
	 <41BC1BF9.70701@colorfullife.com>
	 <20041212121546.GM16322@dualathlon.random>
	 <1103060437.14699.27.camel@krustophenia.net>
	 <20041214222307.GB22043@elte.hu> <20041214224706.GA26853@elte.hu>
	 <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
	 <1103157476.3585.33.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0412151909110.5038@montezuma.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103203594.3804.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 13:26:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 02:10, Zwane Mwaikambo wrote:
> Might this be because you can't rely on interrupt suppression for back to 
> back suppressing instructions?

The documentation seems to have little to say on this. I've also not
tried things like interleaved mov->ss, sti to see how the interlocking
is done. It would make sense given the original 8086 reason was to allow
ss/sp to be loaded cleanly.

