Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVKWMf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVKWMf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKWMf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:35:26 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:28158 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750742AbVKWMf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:35:26 -0500
Date: Wed, 23 Nov 2005 07:35:04 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Maneesh Soni <maneesh@in.ibm.com>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
In-Reply-To: <20051123081845.GA32021@elte.hu>
Message-ID: <Pine.LNX.4.58.0511230727330.23751@gandalf.stny.rr.com>
References: <1132695202.13395.15.camel@localhost.localdomain>
 <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com>
 <20051123081845.GA32021@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2005, Ingo Molnar wrote:

>
> note that Steven has a dual-core Athlon64 X2 system. Steven, do you get
> the crash even with maxcpus=1?
>

Actually Ingo,  this happened on my UP test machine, a 368MHz Pentium.

But unfortunately, it so far only happened once, and I've been trying to
recreate it, with no success.  The test that crashed it was running 10
tasks that would read the entire filesystem. I was debugging another bug
(something specific to my kernel, or maybe -rt) when I hit this bug.
Looking at it, it seemed to not be related to the changes I made.  Perhaps
it could be related to your changes?

-- Steve

PS. I only got my AMD64 x2 to debug your kernel ;-)  I have no requirement
to have my kernel run on it.  I just needed a faster machine, also to move
off my SMP box to make that a test box too. Since I saw lots of people
having problems with -rt and AMD64 I chose to get that one.

