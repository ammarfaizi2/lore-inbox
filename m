Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUHaVxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUHaVxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbUHaUOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:14:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15590 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269130AbUHaUMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:12:53 -0400
Date: Tue, 31 Aug 2004 22:14:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831201420.GA899@elte.hu>
References: <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net> <20040831070658.GA31117@elte.hu> <1093980065.1603.5.camel@krustophenia.net> <20040831193734.GA29852@elte.hu> <1093981634.1633.2.camel@krustophenia.net> <20040831195107.GA31327@elte.hu> <20040831200912.GA32378@elte.hu> <1093983034.1633.11.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093983034.1633.11.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> File under boot-time stuff, I guess.  This could be bad if X crashes,
> but I can't remember the last time this happened to me, and I use xorg
> CVS.

but the first wbinvd() within prepare_set() seems completely unnecessary
- we can flush the cache after disabling the cache just fine.

	Ingo
