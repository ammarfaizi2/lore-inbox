Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTEHJrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbTEHJrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:47:18 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47377 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261252AbTEHJrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:47:13 -0400
Date: Thu, 8 May 2003 09:59:43 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       "arjanv@redhat.com" <arjanv@redhat.com>,
       Steffen Persvold <sp@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508095943.B22255@devserv.devel.redhat.com>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052387912.4849.43.camel@pc-16.office.scali.no>; from terje.eggestad@scali.com on Thu, May 08, 2003 at 11:58:33AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 11:58:33AM +0200, Terje Eggestad wrote:
> I guess something like this:
> 
> typedef int (*syscall_hook_t)(void * arg1, void * arg2, void * arg3,
> void * arg4, void * arg5, void * arg6);
> 
> #define HOOK_IN_FLAG 0x1
> #define HOOK_OUT_FLAG 0x2
> 
> opaquehandle = int register_syscall_hook(int syscall_nr, syscall_hook_t
> hook_function, int flags);
> int unregister(int opaquehandle);
> 
> I'd make a stab at it if I knew that it stood a chance of getting
> accepted. 

I dont think it has.
