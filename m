Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269081AbUHaT4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269081AbUHaT4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269073AbUHaTvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:51:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38366 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268965AbUHaTt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:49:28 -0400
Date: Tue, 31 Aug 2004 21:51:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831195107.GA31327@elte.hu>
References: <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net> <20040831070658.GA31117@elte.hu> <1093980065.1603.5.camel@krustophenia.net> <20040831193734.GA29852@elte.hu> <1093981634.1633.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093981634.1633.2.camel@krustophenia.net>
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

> Commented out all calls to wbinvd(), seems to work fine.  I even tried
> repeatedly killing the X server before it could finish starting, no
> problems at all.
> 
> I guess the worst that could happen here would be display corruption,
> which would get fixed on the next refresh?

it's more complex than that - MTRR's are caching attributes that the CPU
listens to. Mis-setting them can cause anything from memory corruption
to hard lockups. The question is, does any of the Intel (or AMD) docs
say that the CPU cache has to be write-back flushed when setting MTRRs,
or were those calls only done out of paranoia?

	Ingo
