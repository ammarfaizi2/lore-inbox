Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVKINiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVKINiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVKINiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:38:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:46569 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750725AbVKINiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:38:51 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
Date: Wed, 9 Nov 2005 14:38:09 +0100
User-Agent: KMail/1.8
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511081412.05285.ak@suse.de> <4370A9F5.4060103@vmware.com>
In-Reply-To: <4370A9F5.4060103@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511091438.11848.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 14:36, Zachary Amsden wrote:

> One can imagine clever uses for ptrace to do, say user space
> virtualization (since I'm on the topic), or other neat things.  So there
> is nothing really wrong about having the fully correct EIP conversion
> (and here we shouldn't need to worry about races causing some issues
> with strict correctness, since there can be one external control thread).

Well, the code still scaries me a bit, but ok. x86-64 left at least one case 
intentionally out.

> But were kprobes even inteneded for userspace?  There are races here
> that are difficult to close without some heavy machinery, and I would
> rather not put the machinery in place if simplifying the code is the
> right answer.

I believe user space kprobes are being worked on by some IBM India folks yes.

-Andi
