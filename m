Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSLCMsh>; Tue, 3 Dec 2002 07:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSLCMsh>; Tue, 3 Dec 2002 07:48:37 -0500
Received: from ns.suse.de ([213.95.15.193]:28691 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261218AbSLCMsg>;
	Tue, 3 Dec 2002 07:48:36 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "Vamsi Krishna S ." <vamsi@in.ibm.com>, torvalds@transmeta.com,
       lkml <linux-kernel@vger.kernel.org>,
       dprobes <dprobes@www-124.southbury.usf.ibm.com>,
       richard <richardj_moore@uk.ibm.com>, tom <hanrahat@us.ibm.com>
Subject: Re: [PATCH] kprobes for 2.5.50-bk2
References: <20021203125447.A2951@in.ibm.com.suse.lists.linux.kernel> <20021203121858.GC30431@suse.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Dec 2002 13:56:05 +0100
In-Reply-To: Dave Jones's message of "3 Dec 2002 13:28:50 +0100"
Message-ID: <p734r9vtg62.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> This last part just got me thinking.
> What stops someone for example using this to implement a binary
> only replacement of the TCP/IP stack, or any other part of the
> kernel for that matter ?

It can be already easily done, just patch the kernel code in /dev/kmem
and add some jump instructions to your loaded module.

But it's not practical, because it's 100% binary dependent and would
break with every small change.

Similar to kprobes. But kprobes is actually useful for kernel debugging/
tracing and unlike many other of these patches not very intrusive.

-Andi
