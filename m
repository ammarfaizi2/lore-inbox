Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVLMLVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVLMLVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 06:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVLMLVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 06:21:30 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:13526 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750814AbVLMLVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 06:21:30 -0500
Date: Tue, 13 Dec 2005 12:20:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: JANAK DESAI <janak@us.ibm.com>
Cc: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.gov, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 0/9] unshare system call (take 3)
Message-ID: <20051213112029.GA14653@elte.hu>
References: <1134441527.14136.1.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134441527.14136.1.camel@hobbs.atlanta.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* JANAK DESAI <janak@us.ibm.com> wrote:

> Patches are organized as follows:
> 
> 1. Patch implementing system call handler sys_unshare. System call
>    accepts all clone(2) flags but returns -EINVAL when attempt is
>    made to unshare any shared context.
> 2. Patch registering system call for i386 architecture
> 3. Patch registering system call for powerpc architecture
> 4. Patch registering system call for ppc architecture
> 5. Patch registering system call for x86_64 architecture
> 6. Patch implementing unsharing of filesystem information
> 7. Patch implementing unsharing of namespace
> 8. Patch implementing unsharing of vm
> 9. Patch implementing unsharing of files
> 
> Unsharing of singnal handlers is still not implemented. As far as I 
> can tell, issues raised by Chris Wright regarding possible problems 
> stemming from interaction of timers with unsharing of signal handlers, 
> has been resolved by a 2.6.14 patch that fixed race in send_sigqueue 
> with thread exit. However, I do want to understand the code better and 
> experiment with it some more before implementing signal handler 
> unsharing. If deemed ok, it would be easy to add that functionality.

yes, it would be preferrable to have them all at once, once it hits 
upstream. Also, would unsharing the thread group make sense?

	Ingo
