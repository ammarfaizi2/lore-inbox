Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVEPRC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVEPRC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVEPRC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:02:27 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27345 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261757AbVEPRBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:01:42 -0400
Subject: Re: Share Wait Queue between different modules ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050516151107.62046.qmail@web8502.mail.in.yahoo.com>
References: <20050516151107.62046.qmail@web8502.mail.in.yahoo.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 16 May 2005 13:01:35 -0400
Message-Id: <1116262895.10107.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 16:11 +0100, Dinesh Ahuja wrote:
> Hi ,
> 
> Just trying to explore a situation where different
> modules may need to share same wait queues. Could
> anyone tell me the pratical situation where we need to
> have above mentioned situation ?
> 

Have an example of this situation?

> Please clarify me on below point : 
> We say that kernel stack is very much limited around
> 8KB.
> Does all the running processes share this stack or
> each process has 8KB of the space which process can
> access when it is running in kernel mode.
> 

The later.  Each process has its own kernel stack when in kernel mode.

> Sharing wait queues will be difficult if the kernel
> space is 8KB for all the ready processes because then
> the no of wait_queue_t elements which can be added
> will be limited.
> 

As mentioned above, each process has its own kernel stack.


-- Steve


