Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288428AbSAKJya>; Fri, 11 Jan 2002 04:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289124AbSAKJyU>; Fri, 11 Jan 2002 04:54:20 -0500
Received: from ns.suse.de ([213.95.15.193]:42509 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289051AbSAKJyM>;
	Fri, 11 Jan 2002 04:54:12 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <m26669olcu.fsf@goliath.csn.tu-chemnitz.de.suse.lists.linux.kernel> <E16Oocq-0005tX-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Jan 2002 10:54:07 +0100
In-Reply-To: Alan Cox's message of "11 Jan 2002 00:22:35 +0100"
Message-ID: <p737kqpp60w.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> The kernel isnt there to fix up the fact authors can't read. Its also very
> hard to get emulations right. I grant that this wasn't helped by the fact
> the gcc x86 folks also couldnt read the pentium pro manual correctly.

One corner case where emulation would IMHO make sense would be CMPXCHG8.
It would allow to do efficient inline mutexes in pthreads, and hit the
emulation only on 386/486. cpu feature flag checking is unfortunately
not an option normally for inline code.

-Andi (who would have already done it if he had an 486/386 to test) 
