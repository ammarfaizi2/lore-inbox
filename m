Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVKHN0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVKHN0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVKHN0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:26:39 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:11461 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965173AbVKHN0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:26:38 -0500
Date: Tue, 8 Nov 2005 14:26:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 14/21] i386 Apm is on cpu zero only
Message-ID: <20051108132650.GA5850@elte.hu>
References: <200511080433.jA84Xwm7009921@zach-dev.vmware.com> <20051108073315.GE28201@elte.hu> <43709FD7.1030905@vmware.com> <1131458091.25192.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131458091.25192.29.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2005-11-08 at 04:53 -0800, Zachary Amsden wrote:
> > Can't hurt, and APM is largely obsolete because of ACPI, so I'm only 
> > concerned with trimming and keeping adequate protection of the kernel 
> > from APM code while maintaining correctness.  I don't have a nice set of 
> > old machines with enough wacky APM BIOSen to validate that unpinning the 
> > CPU is ok.
> 
> A large number of SMP machines, probably the majority of APM based 
> ones require that APM calls occur on CPU#0. As I understand it from a 
> BIOS engineer involved in debugging that problem Redmond always does 
> APM from CPU #0 and may even guarantee it.

ok, then i'm all for making that more explicit - i.e. Zachary's patch is 
the right one.

	Ingo
