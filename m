Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUHaGdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUHaGdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUHaGcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:32:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20399 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266753AbUHaGaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:30:19 -0400
Date: Tue, 31 Aug 2004 08:31:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831063151.GA29795@elte.hu>
References: <OF8AC76C1C.20634F1C-ON86256F00.007813C0@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8AC76C1C.20634F1C-ON86256F00.007813C0@raytheon.com>
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


* Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:

> >regarding this particular latency, could you try the attached patch
> >ontop of -Q5? It turns the ->poll() loop into separate, individually
> >preemptable iterations instead of one batch of processing. In theory
> >this should result in latency being lower regardless of the
> >netdev_max_backlog value.
> 
> First time - stopped during init script - when trying to start a network
> service (automount).

in theory the patch is more or less equivalent to setting
netdev_max_backlog to a value of 1 - could you try that setting too?
(with the patch unapplied.)

	Ingo
