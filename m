Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbTEHKIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 06:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTEHKIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 06:08:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63379 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261201AbTEHKIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 06:08:12 -0400
Date: Thu, 8 May 2003 11:20:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Steffen Persvold <sp@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508102047.GT10374@parcelfarce.linux.theplanet.co.uk>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no> <20030508095943.B22255@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508095943.B22255@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 09:59:43AM +0000, Arjan van de Ven wrote:
> On Thu, May 08, 2003 at 11:58:33AM +0200, Terje Eggestad wrote:
> > I guess something like this:
> > 
> > typedef int (*syscall_hook_t)(void * arg1, void * arg2, void * arg3,
> > void * arg4, void * arg5, void * arg6);
> > 
> > #define HOOK_IN_FLAG 0x1
> > #define HOOK_OUT_FLAG 0x2
> > 
> > opaquehandle = int register_syscall_hook(int syscall_nr, syscall_hook_t
> > hook_function, int flags);
> > int unregister(int opaquehandle);
> > 
> > I'd make a stab at it if I knew that it stood a chance of getting
> > accepted. 
> 
> I dont think it has.

I think it could, actually - who maintains fortunes these days?  It's
a bit too long, though...
