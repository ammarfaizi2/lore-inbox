Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbUABQ6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 11:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265610AbUABQ6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 11:58:15 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:36483 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265596AbUABQ6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 11:58:13 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 Jan 2004 08:58:09 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040102071215.6D43C2C059@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0312311935080.5831-100000@bigblue.dev.mdolabs.com> yo
> u write:
> > On Wed, 31 Dec 2003, Rusty Russell wrote:
> > 
> > > But an alternate implementation would be to have a "kthread" kernel
> > > thread, which would actually be parent to the kthread threads.  This
> > > means it can allocate and clean up, since it catches *all* thread
> > > deaths, including "exit()".
> > > 
> > > What do you think?
> > 
> > Did you take a look at the stuff I sent you? I'll append here with a 
> > simple comment (this goes over you bits).
> 
> Yes, but I think it's a really bad idea, as I said before.
> 
> Anyway, Here's a version which fixes the issues raised by Andrew by
> doing *everything* in keventd, uses waitpid(), and uses signals for
> communication (except for the case of init failing).

Rusty, you still have to use global static data when there is no need. I 
like this version better though ;)



- Davide


