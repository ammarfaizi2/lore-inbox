Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVLMPDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVLMPDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVLMPDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:03:38 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:43728 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964878AbVLMPDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:03:38 -0500
Subject: Re: [PATCH -RT] fix i386 RWSEM_GENERIC_SPINLOCK (was: Re:
	2.6.15-rc5-rt1 will not compile)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <1134484364.24145.43.camel@localhost.localdomain>
References: <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>
	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
	 <20051129093231.GA5028@elte.hu> <1134090316.11053.3.camel@mindpipe>
	 <1134174330.18432.46.camel@mindpipe> <1134409469.15074.1.camel@mindpipe>
	 <1134424143.24145.6.camel@localhost.localdomain>
	 <20051213081502.GB10088@elte.hu>
	 <1134484364.24145.43.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 10:03:15 -0500
Message-Id: <1134486195.24145.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 09:32 -0500, Steven Rostedt wrote:
> > 
> 
> OK, scratch my last patch.  I'll submit this arch per arch.  Starting
> with i386.  Each arch does it differently, so a generic lib/Konfig.rwsem
> wouldn't work, since each arch has a different dependency.

I guess this may be the only patch needed so far.  x86_64 doesn't use a
RWSEM_XCHGADD_ALGORITHM, and as for the other archs:

alpha and ia64 - doesn't have PREEPMT_RT yet.

arm, cris, frv, h8300, m32r, parsic don't seem to implement the XCHGADD.

But I see that powerpc will need a fix, but I'll let others who actually
have the boards to fix them. ;-)

As for what I own: x86_64 and i386, the patches I sent are sufficient.

If anyone would like to give me a special board (to keep), I'll gladly
make sure that Ingo's -RT kernel runs on it.

-- Steve

