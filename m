Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbTLaG1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 01:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbTLaG1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 01:27:18 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8624 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266136AbTLaG1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 01:27:17 -0500
Date: Wed, 31 Dec 2003 12:01:51 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create
Message-ID: <20031231120151.A22673@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20031231053603.65CA52C08B@lists.samba.org> <Pine.LNX.4.44.0312302149350.1457-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0312302149350.1457-100000@bigblue.dev.mdolabs.com>; from davidel@xmailserver.org on Tue, Dec 30, 2003 at 09:56:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 09:56:05PM -0800, Davide Libenzi wrote:
> Also, what happens in the task woke up by a send does not reschedule 
> before another CPU does another send? Wouldn't a message be lost?
> 

The messages should not be lost because we take the cpucontrol
semaphore in kthread_start or kthread_destroy before sending 
a (start or destroy) message.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560033
