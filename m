Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTAUXGe>; Tue, 21 Jan 2003 18:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbTAUXGe>; Tue, 21 Jan 2003 18:06:34 -0500
Received: from asclepius.uwa.edu.au ([130.95.128.56]:21650 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id <S267263AbTAUXGd>; Tue, 21 Jan 2003 18:06:33 -0500
Subject: Re: [PATCH][2.5] smp_call_function_mask
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E2CF327.8030107@colorfullife.com>
References: <3E2CF327.8030107@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043190888.1382.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 21 Jan 2003 23:14:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 07:13, Manfred Spraul wrote:
> Alan wrote:
> 
> >On Fri, 2003-01-17 at 05:18, Zwane Mwaikambo wrote:
> >> +	/* Wait for response */
> >> +	while (atomic_read(&data.started) != num_cpus)
> >> +		barrier();
> >
> >Only old old intel x86 that does -bad- things as it
> >generates a lot of bus locked cycles. Better to do
> >
> >	while(atomic_read(&data.started) != num_cpus)

> from 2.5.52, <asm-i386/atomic.h>
>     #define atomic_read(v)          ((v)->counter)
> AFAIK atomic_read never contained locked bus cycles.

For x86 at least it never did, you are right. Must be time for
a brain transplant



