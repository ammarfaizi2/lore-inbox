Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265644AbUGHJax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbUGHJax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 05:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGHJax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 05:30:53 -0400
Received: from av4-1-sn3.vrr.skanova.net ([81.228.9.111]:56739 "EHLO
	av4-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S265644AbUGHJaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 05:30:52 -0400
Date: Thu, 8 Jul 2004 11:30:45 +0200 (CEST)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@best.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
In-Reply-To: <40ED049B.2020406@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0407081126360.3104@telia.com>
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au>
 <m2fz82hq8c.fsf@telia.com> <20040708012005.6232a781.akpm@osdl.org>
 <40ED049B.2020406@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2004, Nick Piggin wrote:

> Andrew Morton wrote:
> > Peter Osterlund <petero2@telia.com> wrote:
>
> >>Doesn't help. My test program still fails in the same way.
> >
> > Something odd is happening - I've run that testcase in various shapes and
> > forms a huge number of times.
> >
> > What filesystems are in use?  Is there anything unusual about the setup?
> > Do earlier 2.6 kernels exhibit the same problem?  Is something wrong with
> > the disk system?

I use only ext3, the disc system is working fine AFAIK. 2.6.7-bk10 has the
same problem, 2.6.7-bk2 completes the test case, but it takes 50-70s, and
the system is completely frozen until the program finishes.

> Also, have you changed /proc/sys/vm/swappiness?

swappiness is set to 60.

However, I realized that I had set /proc/sys/vm/laptop_mode to 1. If I set
it to 0, 2.6.7-bk10 starts to work.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
