Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVBFNbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVBFNbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVBFNbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:31:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:26786 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261232AbVBFNbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:31:41 -0500
Date: Sun, 6 Feb 2005 14:31:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206133133.GA4124@elte.hu>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de> <1107695097.22680.92.camel@laptopd505.fenrus.org> <20050206130929.GI30109@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206130929.GI30109@wotan.suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> On Sun, Feb 06, 2005 at 02:04:57PM +0100, Arjan van de Ven wrote:
> > 
> > > Hmm, I got a report that it doesn't work anymore with 
> > > 2.6.11rcs on x86-64. I haven't looked  closely yet,
> > > but it wouldn't surprise me if this change isn't also involved.
> > 
> > PT_GNU_STACK change is there since like 2.6.6 (and was put in by a suse person)
> > To me that is a strong indication that you are wrong on your
> > suspicion...
> 
> Nah, the change to break 32bit userland mmap/mprotect like this was only 
> put in after 2.6.10. 

i suspect there may be some fundamental misunderstanding here. The
change to honor PT_GNU_STACK (on 64-bit) was added in April 2004 and
appeared in 2.6.6. The change to enforce the protection bits on x86 NX
CPUs (32-bit) was added in June 2004 and appeared in 2.6.8. I.e. it's
been part of the upstream kernel for more than half a year. Try it and
boot 2.6.8, you'll get NX protection. (I'm not sure about when it was
enabled for 32-bit emulation on the x64 kernel, you should be the one to
know that - but IIRC it was enabled prior 2.6.10.)

so i think you are on to the wrong victim :-)

	Ingo
