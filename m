Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266258AbUG0G6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUG0G6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 02:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUG0G6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 02:58:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46533 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266258AbUG0G54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 02:57:56 -0400
Date: Tue, 27 Jul 2004 08:43:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: no luck with max_sectors_kb (Re: voluntary-preempt-2.6.8-rc2-J4)
Message-ID: <20040727064345.GA5594@elte.hu>
References: <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu> <20040726101536.GA29408@elte.hu> <20040726204228.GA1231@ss1000.ms.mff.cuni.cz> <20040726205741.GA27527@elte.hu> <20040726225009.GA2369@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726225009.GA2369@ss1000.ms.mff.cuni.cz>
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


* Rudo Thomas <rudo@matfyz.cz> wrote:

> > does the patch below, ontop of -J7, help?
> 
> I tried it, but did not test tuning the value, as the patch has
> problems of its own: with device-mapper.
> 
> bio too big device dm-0 (256 > 255)
> 
> Again, some files cannot be read on the device.

ok, dm (and some other layered block drivers) set q->max_sectors
directly instead of using blk_queue_max_sectors().

	Ingo
