Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVDEFjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVDEFjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 01:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVDEFjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 01:39:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33173 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261494AbVDEFjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 01:39:12 -0400
Date: Tue, 5 Apr 2005 07:39:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Frank Rowand <frowand@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ppc RT: Realtime preempt support for PPC
Message-ID: <20050405053906.GA19062@elte.hu>
References: <422CCC1D.1050902@mvista.com> <20050316100914.GA16012@elte.hu> <423F691E.200@mvista.com> <424B542F.9090308@mvista.com> <20050331091614.GB22397@elte.hu> <424DDF5F.9080909@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424DDF5F.9080909@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Frank Rowand <frowand@mvista.com> wrote:

> I looked at all the architectures and found that the disparity of the 
> type of the "lock" field in struct rwlock_t is even larger than I had 
> indicated in my earlier email.  I am attaching a proof of concept 
> patch to handle this.  If this looks like a good method to you then I 
> will create a real patch against your current patch, and include i386, 
> mips, x86_64, and ppc.

> +#include <asm/raw_spinlock.h>

>  typedef struct {
> -       volatile unsigned long lock;
> +       ARCH_RAW_RWLOCK_LOCK

maybe the simplest method would be to let architectures to define the 
raw spinlock type after all. I was hoping to standardize things across 
all architectures, but maybe it's not possible.

	Ingo
