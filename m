Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbUJ1XrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbUJ1XrC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbUJ1Xpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:45:32 -0400
Received: from colin2.muc.de ([193.149.48.15]:14349 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263141AbUJ1XlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:41:20 -0400
Date: 29 Oct 2004 01:41:19 +0200
Date: Fri, 29 Oct 2004 01:41:19 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: prasanna@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, suparna@in.ibm.com,
       dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [0/3] PATCH Kprobes for x86_64- 2.6.9-final
Message-ID: <20041028234119.GB80511@muc.de>
References: <20041028113208.GA11182@in.ibm.com> <20041028113744.GA82042@muc.de> <20041028111554.6879f3ca.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028111554.6879f3ca.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kprobe notifier has to run for the case where the kernel
> does a userspace access and faults.  This is to handle the
> case of setting a kprobe on a userspace access instruction.
> In such a event, we must unwind the reset the program counter
> so that exception table processing is done with the correct
> PC not the temporary one kprobes is using to execute the
> instruction where the breakpoint currently lives.

Ok that makes sense. Thanks for the explanation (the original 
submitter didn't give one). 

-Andi

