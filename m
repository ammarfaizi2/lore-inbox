Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUH1VQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUH1VQr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUH1VMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:12:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18860 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267926AbUH1VMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:12:24 -0400
Date: Sat, 28 Aug 2004 23:13:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q3
Message-ID: <20040828211334.GA32009@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <1093715573.8611.38.camel@krustophenia.net> <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu> <1093727453.8611.71.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093727453.8611.71.camel@krustophenia.net>
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

> On Sat, 2004-08-28 at 16:31, Ingo Molnar wrote:
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q3
> > 
> 
> I get this error: 
> 
> WARNING: /lib/modules/2.6.9-rc1-Q3/kernel/fs/ntfs/ntfs.ko needs unknown symbol unlock_kernel
> WARNING: /lib/modules/2.6.9-rc1-Q3/kernel/fs/ntfs/ntfs.ko needs unknown symbol lock_kernel
> 
> I believe this is the correct fix:
> 
> --- fs/ntfs/super.c~	2004-08-28 16:31:33.000000000 -0400
> +++ fs/ntfs/super.c	2004-08-28 17:08:11.000000000 -0400
> @@ -29,6 +29,7 @@
>  #include <linux/buffer_head.h>
>  #include <linux/vfs.h>
>  #include <linux/moduleparam.h>
> +#include <linux/smp_lock.h>
>  
>  #include "ntfs.h"
>  #include "sysctl.h"

ok, will add this to -Q4.

	Ingo
