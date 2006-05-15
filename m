Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWEOT0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWEOT0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWEOT0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:26:37 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20189 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751255AbWEOT0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:26:36 -0400
Date: Mon, 15 May 2006 21:26:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515192614.GA24887@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <200605152037.54242.ak@suse.de> <1147719901.6623.78.camel@localhost.localdomain> <200605152111.20693.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605152111.20693.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > x86 is a legacy architecture now anyway, right? ;)
> I wish everybody would agree on that @)

as far as i'm concerned x86 is obsolete: my main devel and testboxes are 
64-bit throughout, and i develop for 64-bit by default.

Nevertheless for hard-to-debug bugs i prefer if they can be reproduced 
and debugged on 32-bit too, because x86_64 debugging is still quite a 
PITA and wastes alot of time: for example it has no support for exact 
kernel stacktraces. Also, the printout of the backtrace is butt-ugly and 
as un-ergonomic to the human eye as it gets - who came up with that 
"two-maybe-one function entries per-line" nonsense? [Whoever did it he 
never had to look at (and make sense of) hundreds of stacktraces in a 
row.]

Also, the majority of kernel bugs still get reported on 32-bit and most 
of the testers are on 32-bit. So x86_64 is nice but it still needs some 
work, mainly in terms of debuggability.

	Ingo
