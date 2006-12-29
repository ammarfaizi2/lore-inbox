Return-Path: <linux-kernel-owner+w=401wt.eu-S965066AbWL2V1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWL2V1v (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 16:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWL2V1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 16:27:50 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56341 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965066AbWL2V1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 16:27:49 -0500
Date: Fri, 29 Dec 2006 13:23:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, Ollie Wild <aaw@google.com>,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       Arjan van de Ven <arjan@infradead.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] remove MAX_ARG_PAGES
In-Reply-To: <20061229204904.GI20596@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612291322150.4473@woody.osdl.org>
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
 <1160572460.2006.79.camel@taijtu> <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com>
 <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com>
 <20061229200357.GA5940@elte.hu> <20061229204904.GI20596@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Russell King wrote:
> 
> Suggest you test (eg) a rebuild of libX11 to see how it reacts to
> this patch.

Also: please rebuild "xargs" and install first. Otherwise, a lot of 
build script etc that use "xargs" won't ever trigger the new limits (or 
lack thereof), because xargs will have been installed with some old 
limits.

Perhaps more worrying is if compiling xargs under a new kernel then means 
that it won't work correctly under an old one.

		Linus
