Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUHJNC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUHJNC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUHJNCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:02:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13714 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265106AbUHJNAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:00:36 -0400
Date: Tue, 10 Aug 2004 15:01:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>, V13 <v13@priest.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810130122.GA26326@elte.hu>
References: <200408091217.50786.jbarnes@engr.sgi.com> <20040810100234.GN11200@holomorphy.com> <20040810115307.GR11200@holomorphy.com> <200408101552.22501.v13@priest.com> <20040810125140.GU11200@holomorphy.com> <20040810125529.GA22650@elte.hu> <20040810125651.GV11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810125651.GV11200@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> On Tue, Aug 10, 2004 at 02:55:29PM +0200, Ingo Molnar wrote:
> > i'd guess it's the con->write() in __call_console_drivers() that makes
> > the difference. (i.e. touching the framebuffer)
> 
> This is serial port IO; would that make the same kind of difference?

serial port IO is even more heavy, it also generates IRQ traffic. I'd
suggest the following tests: modified kernel without serial console, and
original kernel without serial console. This way you can find out 
whether the hang itself is triggered by the serial console.

another attack angle is to find out what state the system has during the
hang. Is it debuggable?

	Ingo
