Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUHJIJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUHJIJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUHJIJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:09:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26031 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261426AbUHJIJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:09:38 -0400
Date: Tue, 10 Aug 2004 10:08:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810080801.GA26014@elte.hu>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com> <20040810063445.GE11200@holomorphy.com> <20040810080430.GA25866@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810080430.GA25866@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > -	if (!keventd_up() || current_is_keventd())
> > -		work.func(work.data);
> > -	else {
> > -		schedule_work(&work);
> > -		wait_for_completion(&c_idle.done);
> > -	}
> 
> is keventd_up() true during normal SMP bootup? [...]

it ought to be up at this point - smp_init() is done from the init
thread and the scheduler is up and running.

	Ingo
