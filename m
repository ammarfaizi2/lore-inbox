Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVJFTwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVJFTwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVJFTwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:52:10 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:9165 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751336AbVJFTwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:52:09 -0400
Date: Thu, 6 Oct 2005 21:52:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt10 - xruns & config questions
Message-ID: <20051006195242.GA15448@elte.hu>
References: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

>    I am still getting a few xruns even after raising Jack's priority 
> level to 80. I am wondering whether it's fair to report these when I 
> have CONFIG_DEBUG_PREEMPT set?

>   4559  78     38 [IRQ 58]

>   58:     257570   IO-APIC-level  hdsp

IRQ 58 is your audio interrupt, right? You should raise that one to prio 
80 too. (via chrt)

> Since my NIC is getting a higher priority than both my sound card and 
> my 1394 audio drives (IRQ217 vs. IRQ58/IRQ66) I assume that network 
> activity might possibly sometimes cause a problem? Or is this not 
> true?

yeah, that could be the case.

	Ingo
