Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVAGMdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVAGMdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVAGMbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:31:51 -0500
Received: from mail19.bluewin.ch ([195.186.18.65]:25562 "EHLO
	mail19.bluewin.ch") by vger.kernel.org with ESMTP id S261389AbVAGMbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:31:13 -0500
Date: Fri, 7 Jan 2005 13:30:53 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A new entry for /proc
Message-ID: <20050107123053.GA29097@k3.hellgate.ch>
References: <3f250c7105010613115554b9d9@mail.gmail.com> <20050106202339.4f9ba479.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106202339.4f9ba479.akpm@osdl.org>
X-Operating-System: Linux 2.6.10-bk9 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2005 20:23:39 -0800, Andrew Morton wrote:
> Mauricio Lin <mauriciolin@gmail.com> wrote:
> >
> > Here is a new entry developed for /proc that prints for each process
> > memory area (VMA) the size of rss. The maps from original kernel is
> > able to present the virtual size for each vma, but not the physical
> > size (rss). This entry can provide an additional information for tools
> > that analyze the memory consumption. You can know the physical memory
> > size of each library used by a process and also the executable file.
> > 
> > Take a look the output:
> > # cat /proc/877/smaps
> > 08048000-08132000 r-xp  /usr/bin/xmms
> > Size:     936 kB
> > Rss:     788 kB
> 
> This is potentially quite useful.  I'd be interested in what others think of
> the idea and implementation.

With split interfaces (machine-/human-readable) as proposed a few months
ago, we wouldn't need to clutter /proc with such cruft. We could simply
add the obvious field to /proc/maps and add another field to nproc.

Using procfs for both humans and software means over time it will get
worse for _both_ sides, and switching to a saner solution won't get
cheaper, either. I still believe we should bite that bullet now.

Roger
