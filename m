Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266466AbUHIKqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUHIKqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUHIKqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:46:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44473 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266466AbUHIKqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:46:32 -0400
Date: Mon, 9 Aug 2004 12:46:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040809104649.GA13299@elte.hu>
References: <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801193043.GA20277@elte.hu>
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


here's the latest version of the voluntary-preempt patch:
   
  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc3-O4

(it should apply to -rc2 cleanly too.)

-O4 fixes a two more latency sources:

 - mlockall() triggering latencies (reported by Thomas Charbonnel, Lee
   Revell and Florian Schmidt)

 - CDROM umount triggering latencies (reported by Florian Schmidt)

there's also a fix for the CONFIG_PCI_MSI compilation bug reported by
Edouard Gomez.

(the APIC bug has not been found yet so either turn off all APIC options
in .config or use noapic if you intend to use voluntary_preempt=3.)

the preempt-timing-on-2.6.8-rc2-O2 patch applies cleanly to -O4.

	Ingo
