Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbTFQUix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTFQUix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:38:53 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:2579 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264943AbTFQUg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:36:58 -0400
Date: Tue, 17 Jun 2003 21:50:51 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Robert Love <rml@tech9.net>
cc: Gerhard Mack <gmack@innerfire.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71 - random console corruption
In-Reply-To: <1055806828.7069.176.camel@localhost>
Message-ID: <Pine.LNX.4.44.0306172149490.21214-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > For userland<->kernel transactions we have the console_semaphore to 
> > protect us. It is also used for console_callback. The console_semaphore is
> > not used internally to protect global variables :-( To do this properly 
> > would take quite a bit of work.  
> 
> It looks like all these globals need a lock -- they can race on SMP or
> with kernel preemption.
> 
> Is it really going to be that hard to wrap a lock around their access,
> because I think this is going to bite SMP users.

For things like fg_console and currcon it will be. Those variables are 
used everyway like mad. That is a whole lot of locks. I doubt this issue 
will be solved until 2.7.X.


