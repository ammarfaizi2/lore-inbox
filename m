Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUGBEWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUGBEWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 00:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUGBEWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 00:22:22 -0400
Received: from nevyn.them.org ([66.93.172.17]:65448 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266477AbUGBEWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 00:22:19 -0400
Date: Fri, 2 Jul 2004 00:22:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, mingo@redhat.com, cagney@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
Message-ID: <20040702042208.GA8896@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	mingo@redhat.com, cagney@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040701203455.GA22888@nevyn.them.org> <200407012159.i61LxKBw022917@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407012159.i61LxKBw022917@magilla.sf.frob.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 02:59:20PM -0700, Roland McGrath wrote:
> > I am not the originator of PTRACE_O_TRACESYSGOOD, I just had the bad
> > luck to touch it.
> 
> My apologies.
> 
> > I think reporting the system call using 0x80|SIGTRAP when you
> > PTRACE_SINGLESTEP over the trap instruction makes excellent good sense.
> 
> If you are not concerned about existing users of PTRACE_O_TRACESYSGOOD
> calling PTRACE_SINGLESTEP and then being confused, then I have no objection.
> I consider you to be the authority on any such users there might be.
> 
> In that case, I'm happy to endorse Davide's original patch.
> I will look into extending it to cover x86-64's ia32 support as well.

I don't know of any example users.  I'm sure there are a couple
somewhere, though.  The new behavior seems intuitively useful to me, so
I'd prefer Davide's original patch.

-- 
Daniel Jacobowitz
