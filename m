Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265678AbUFDJiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUFDJiO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUFDJiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:38:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29114 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265678AbUFDJf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:35:57 -0400
Date: Fri, 4 Jun 2004 11:36:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gerhard Mack <gmack@innerfire.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040604093658.GD11034@elte.hu>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406031031480.14817@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406031031480.14817@innerfire.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gerhard Mack <gmack@innerfire.net> wrote:

> >  kernel tried to access NX-protected page - exploit attempt? (uid: 500)
> >  Unable to handle kernel paging request at virtual address f78d0f40
> >   printing eip:
> >  ...
> 
> Just a small nitpick...
> 
> Can you please drop the "- exploit attempt" from the error?  Buffer
> overflows aren't always exploits.

this message will only trigger if the kernel tries to _execute_ an
non-executable kernel page - which almost never happens even considering
kernel crashes. Normal kernel oopses will still look like they used to.

	Ingo
