Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751957AbWI3UtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWI3UtD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWI3UtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:49:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14215 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751935AbWI3UtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:49:00 -0400
Date: Sat, 30 Sep 2006 13:47:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <200609302230.24070.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609301344231.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org> <200609302230.24070.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Andi Kleen wrote:
> 
> We didn't so far find any bug in the unwinder code itself (ok if you don't
> count the performance issue Ingo found) just lots in the annotations and one
> bug in the dwarf2 standard.

I don't think it matters if it's a bug in the unwinding code or in the 
data generated for it. It's still a bug in the unwinder.

Those bugs have been compiler bugs, manual annotation bugs, and it 
doesn't _matter_ what kind of bugs. The end result is the same: the 
unwinder is buggy.

> If you kick the people who add more than three levels of callback
> to core driver code to get their acts together too that's fine 
> to me. Unfortunately I don't think that's realistic. So we clearly
> need better unwinding.

I dispute the "clearly". We didn't have _that_ many problems with just 
manually filtering out obvious left-overs from some previous callchain.

I mean, really: Andi, point me to anything that was a real problem when we 
had no unwinder at all?

			Linus
