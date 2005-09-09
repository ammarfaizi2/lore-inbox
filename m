Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVIIHLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVIIHLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbVIIHLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:11:04 -0400
Received: from fsmlabs.com ([168.103.115.128]:50342 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751418AbVIIHLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:11:03 -0400
Date: Fri, 9 Sep 2005 00:17:44 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Keith Owens <kaos@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Scheduler hooks to support separate ia64 MCA/INIT stacks
In-Reply-To: <6922.1126231851@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0509082356390.978@montezuma.fsmlabs.com>
References: <6922.1126231851@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Keith Owens wrote:

> The new ia64 MCA/INIT handlers[1] (think of them as super NMI) run on
> separate stacks.  99% of the changes for these new handlers is ia64
> only code, however they need a couple of scheduler hooks to support
> these extra stacks.  The complete patch set will be coming through the
> ia64 tree, this RFC covers just the scheduler changes, so they do not
> come as a surprise when the ia64 tree is rolled up.
> 
> [1] http://marc.theaimsgroup.com/?l=linux-ia64&m=112537827113545&w=2
>     and the following patches.

Thanks that gave a lot of background.

> This patch adds two small hooks that can be safely called from MCA/INIT
> context.  If other architectures want to support NMI on separate stacks
> then they can also use these functions.

Well x86_64 already does this with NMI being setup as ISTs, the difference 
is that there we use a register to access current (via PDA/%gs). I might 
have missed this in the URL you posted, but how come IA64 can't do this 
via r13?

Thanks,
	Zwane

