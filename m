Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUIIUth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUIIUth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUIIUtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:49:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46267 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266117AbUIIUtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:49:20 -0400
Date: Thu, 9 Sep 2004 22:49:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, zwane@linuxpower.ca, hch@infradead.org,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, scott@timesys.com,
       arjanv@redhat.com
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040909204954.GA8635@elte.hu>
References: <20040908120613.GA16916@elte.hu> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu> <200409092224.49690.rjw@sisk.pl> <20040909134047.41aab7a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909134047.41aab7a4.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > I've got this trace (on x86-64):
> > 
> >  general protection fault: 0000 [1] PREEMPT
> >  CPU 0
> >  Modules linked in: usbserial parport_pc lp parport joydev sg st sd_mod sr_mod 
> >  scsi_mod snd_seq_oss snd_seq_midi_evend
> >  Pid: 694, comm: kjournald Not tainted 2.6.9-rc1-mm4
> >  RIP: 0010:[<ffffffff802ac605>] 
> >  <ffffffff802ac605>{__journal_clean_checkpoint_list+389}
> 
> You should revert
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/broken-out/journal_clean_checkpoint_list-latency-fix.patch
> - it seems to be sick.

the variant in the VP patch (for this latency) is pretty stable. Will
post splitups later.

	Ingo
