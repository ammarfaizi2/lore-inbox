Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVB0LGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVB0LGD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 06:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVB0LGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 06:06:02 -0500
Received: from [61.135.145.13] ([61.135.145.13]:42019 "EHLO
	websmtp2.mail.sohu.com") by vger.kernel.org with ESMTP
	id S261374AbVB0LFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 06:05:52 -0500
Message-ID: <4365289.1109502351571.JavaMail.postfix@mx20.mail.sohu.com>
Date: Sun, 27 Feb 2005 19:05:51 +0800 (CST)
From: <stone_wang@sohu.com>
To: "Andrew Morton" <akpm@osdl.org>, <riel@redhat.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH] Linux-2.6.11-rc5: kernel/sys.c setrlimit() RLIMIT_RSS
 cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 210.21.32.84
X-Priority: 3
X-SHMOBILE: 0
X-Sohu-Antivirus: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a buddy who encountered the "ulimit" confusion,
when he and his team deployed Linux as the platform for a multi-user online programming test competition system.

And generally, i think the kernel/system shall work as it said(return of syscalls/output of commands) :)

But rss limit might be a historical issue, with already many applications depending on it :(

Stone Wang

-----  Original Message  -----
From: Andrew Morton 
To: stone_wang@sohu.com 
Cc: riel@redhat.com ;linux-mm@kvack.org ;linux-kernel@vger.kernel.org 
Subject: Re: [PATCH] Linux-2.6.11-rc5: kernel/sys.c setrlimit() RLIMIT_RSS
 cleanup
Sent: Sun Feb 27 18:31:36 CST 2005

> 
> <stone_wang@sohu.com> wrote:
> >
> > $ ulimit  -m 100000
> >  bash: ulimit: max memory size: cannot modify limit: Function not implemented
> 
> I don't know about this.  The change could cause existing applications and
> scripts to fail.  Sure, we'll do that sometimes but this doesn't seem
> important enough.

