Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVKIQ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVKIQ6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVKIQ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:58:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:16877 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932138AbVKIQ6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:58:20 -0500
Date: Wed, 9 Nov 2005 17:58:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, prasanna@in.ibm.com,
       ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
Message-ID: <20051109165804.GA15481@elte.hu>
References: <200511080439.jA84diI6009951@zach-dev.vmware.com> <200511081412.05285.ak@suse.de> <4370A9F5.4060103@vmware.com> <200511091438.11848.ak@suse.de> <437227FD.6040905@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437227FD.6040905@vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> >I believe user space kprobes are being worked on by some IBM India folks 
> >yes.
> 
> I'm convinced this is pointless.  What does it buy you over a ptrace 
> based debugger?  Why would you want extra code running in the kernel 
> that can be done perfectly well in userspace?

kprobes are not just for 'debuggers', they are also used for tracing and 
other dynamic instrumentation in projects like systemtap. Ptrace is way 
too slow and limited for things like that.

	Ingo
