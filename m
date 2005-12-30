Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVL3V4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVL3V4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 16:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVL3V4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 16:56:05 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:41186 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964792AbVL3V4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 16:56:02 -0500
Date: Fri, 30 Dec 2005 16:55:49 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] protect remove_proc_entry
In-Reply-To: <1135978466.32431.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0512301654460.29185@gandalf.stny.rr.com>
References: <1135973075.6039.63.camel@localhost.localdomain> 
 <1135978110.6039.81.camel@localhost.localdomain> <1135978466.32431.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Dec 2005, Daniel Walker wrote:

> On Fri, 2005-12-30 at 16:28 -0500, Steven Rostedt wrote:
>
> > +	spin_lock_irqsave(&remove_proc_lock, flags);
> ...
> > +	spin_unlock_irqrestore(&remove_proc_lock, flags);
>
> Why do an irqsave here? Are you not sure what context it gets called
> from?
>

[snipped from original message]
"I'm not sure if remove_proc_entry is called from interrupt context, so I
did a irqsave just in case."

  ;-)

-- Steve


