Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269213AbUIHXg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269213AbUIHXg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269220AbUIHXg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:36:58 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13993 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269218AbUIHXfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:35:09 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark_H_Johnson@raytheon.com
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
In-Reply-To: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
References: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094682656.12371.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 23:31:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 21:33, Mark_H_Johnson@raytheon.com wrote:
> >.... Please disable IDE DMA and see
> >what happens (after hiding the PIO IDE codepath via
> >touch_preempt_timing()).
> 
> Not quite sure where to add touch_preempt_timing() calls - somewhere in the
> loop in ide_outsl and ide_insl? [so we keep resetting the start /end
> times?]

If you haven't done hdparm -u1 that may be a reason you want to touch
these. To defend against some very bad old h/w where a stall in the I/O
stream to the disk causes corruption we disable IRQ's across the
transfer in PIO mode by default.

