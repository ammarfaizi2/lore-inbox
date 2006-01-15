Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWAOUAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWAOUAb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAOUAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:00:31 -0500
Received: from thorn.pobox.com ([208.210.124.75]:42391 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S932127AbWAOUAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:00:30 -0500
Date: Sun, 15 Jan 2006 13:00:24 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
Subject: Re: state terminology
Message-Id: <20060115130024.0db8fb1c.dickson@permanentmail.com>
In-Reply-To: <200601151058.55369.ioe-lkml@rameria.de>
References: <Pine.LNX.4.61.0601142234280.23423@yvahk01.tjqt.qr>
	<200601151058.55369.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2006 10:58:48 +0100, Ingo Oeser wrote:

> Hi Jan,
> 
> On Saturday 14 January 2006 22:34, you wrote:
> > Is there a specific term (other than "hang") associated with this 
> > situation? It's not a "dead-lock", because there is no other process 
> > (anymore) which could potentially up the semaphore.
> 
> This is a simple "resource leak" (or "semaphore leak" in this case).
> 
> Explanation follows:
> 
> The resource semaphore is not usable by anyone anymore 
> and is still around.
> 
> Its pretty much the same as a memory leak. There is no one, who
> could free the memory anymore.
> 
> The reasons for the resource not being usable anymore is
> not significant for a resource leak.
> 
> Also insignificant is the fact that the amount of semaphores
> are just limited by available memory. If you repeat starting threads 
> doing the semaphore leak game from your example, you'll run out
> of memory and thus out of semaphores. This is another sign of leakage.
> 
> Do the above explanations sound ok?

But it's the functionality rather than the resource that's being lost.
So I wouldn't consider it to be a leak.

How about "locked-out" or "lock-out"?  It's akin to a locked room, with
the keys left inside.

	-Paul

