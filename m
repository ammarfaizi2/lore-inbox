Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUACDnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 22:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbUACDnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 22:43:46 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:35200 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262564AbUACDnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 22:43:45 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 Jan 2004 19:43:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040103030802.BD1DB2C06E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0401021919240.825-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com> you write:
> > Rusty, you still have to use global static data when there is no need.
> 
> And you're still putting obscure crap in the task struct when there's
> no need.  Honestly, I'd be ashamed to post such a patch.

Ashamed !? Take a look at your original patch and then define shame. You 
had a communication mechanism that whilst being a private 1<->1 
communication among two tasks, relied on a single global message 
strucure, lock and mutex. Honestly I do not like myself to add stuff 
inside a strcture for one-time use. Not because of adding 12 bytes to the 
struct, that are laughable. But because it is used by a small piece of 
code w/out a re-use ability for other things.



> > I like this version better though ;)
> 
> I think I should seek a second opinion though.

But of course, even a third one ;)



- Davide




