Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTHaRb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTHaRb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:31:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41162 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262497AbTHaRbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:31:23 -0400
Date: Sun, 31 Aug 2003 14:34:01 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
Message-ID: <Pine.LNX.4.44.0308311433410.16240-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Sun, 31 Aug 2003 12:43:27 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
     Mike Fedyk <mfedyk@matchmail.com>, Antonio Vargas <wind@cocodriloo.com>,
     lkml <linux-kernel@vger.kernel.org>,
     Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Andrea VM changes



On Sun, 31 Aug 2003, Andrea Arcangeli wrote:

> This oom killer on desktops may do a worse selections of the task to
> kill (the usual ssh now has a chance to be killed), but it fixes the oom
> deadlocks and it won't do stupid things on servers shall a netscape or
> whatever else app hit an userspace bug. So I've to prefer it, until I
> will write a reliable algorithm for the oom killing that won't fall into
> dosable corner cases so easily (mlock/nfs/database as the three most
> common examples of where current mainline can fail, btw the lowmem
> shortage is another very common DoS that the oom killer will never
> notice, my tree doesn't deadlock [or at least not technically, in
> practice it may look like a kernel deadlock despite syscalls returns
> -ENOMEM ;) ] during lowmem shortage on the 64G boxes).

Suppose you have a big fat hog leaking (lets say, netscape) allocating
pages at a slow pace. Now you have a decent well behaved app who is
allocating at a fast pace, and gets killed.

The chance the well behaved app gets killed is big, right? 


