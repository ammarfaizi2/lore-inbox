Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbTGJXjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269683AbTGJXjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:39:54 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22930 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266528AbTGJXju
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:39:50 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 10 Jul 2003 16:46:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.75
In-Reply-To: <Pine.LNX.4.44.0307101632100.5091-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.55.0307101644090.4631@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0307101632100.5091-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003, Linus Torvalds wrote:

> > Sometime ago, I made down a combo patch and, sincerely, it's the one I'm
> > using the most for my desktop boxes as it's the one that gets better
> > response times and interactive feeling. For my server boxes, neither my
> > combo patch, neither Con or stock do feel good when the system is under
> > heavy load. It suffers from starvation. Simply doing a "tar jxvf" makes
> > logging into the system a PITA.
>
> And this one is almost certainly not a process scheduler issue, but an IO
> scheduler one. 2.5.75 may help that a bit - anticipatory IO scheduling
> from the -mm tree, and a much simpler (and in my tests, noticeably faster
> and more robust) executable mmap prefetcher.
>
> But as with process scheduling, I don't believe in "perfect". It will just
> have to be "good enough for a lot of people".

Indeed. Yesterday while I was doing the SOFTRR hack I had after a quite
long time the opportunity to test the current scheduler interactivity. To
me it looks very good. My usual `make -j 40 bzImage` let my system
completely usable. If all this noise was for the tar thingy maybe we are
responsible to not have well read the thread to stop it soon.



- Davide

