Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282797AbRK0Ei2>; Mon, 26 Nov 2001 23:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282798AbRK0EiS>; Mon, 26 Nov 2001 23:38:18 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:18186 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282797AbRK0EiH>; Mon, 26 Nov 2001 23:38:07 -0500
Date: Mon, 26 Nov 2001 20:48:18 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc-based cpu affinity user interface
In-Reply-To: <Pine.LNX.4.40.0111262026380.1674-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.40.0111262046370.1674-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Davide Libenzi wrote:

> Something like :
>
> unsigned long num2log_mask(unsigned long cmsk) {
> 	unsigned long msk = 0;
> 	int ii;
>
> 	for (ii = 0; ii < smp_num_cpus; ii++)
> 		if (cmsk & (1 << ii))
> 			msk |= (1 << cpu_logical_map(ii));
> 	return msk;
> }
>
> unsigned long log2num_mask(unsigned long cmsk) {
> 	unsigned long msk = 0;
> 	int ii;
>
> 	for (ii = 0; ii < smp_num_cpus; ii++)

	for (ii = 0; ii < NR_CPUS; ii++)





- Davide


