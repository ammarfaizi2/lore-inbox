Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270243AbTGMQBo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270244AbTGMQBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:01:44 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:45957 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270243AbTGMQBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:01:36 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 09:08:52 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Pavel Machek <pavel@ucw.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
In-Reply-To: <20030713115033.GA371@elf.ucw.cz>
Message-ID: <Pine.LNX.4.55.0307130903570.14680@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0307091929270.4625@bigblue.dev.mcafeelabs.com>
 <20030713115033.GA371@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, Pavel Machek wrote:

> Hi!
>
> > I finally found a couple of hours for this and I also found a machine were
> > I can run 2.5, since luck abandoned myself about this. The small page
> > describe the obvious and contain the trivial patch and the latecy test app :
> >
> > http://www.xmailserver.org/linux-patches/softrr.html
>
> What happens if evil user forks 60 processes, marks them all
> SCHED_SOFTRR, and tries to starve everyone else?

Oh, no doubt you can do it. The SOFTRR thing can be fixed for this, pretty
easily. The problem, like Alan is saying, is that with the current
scheduler you do not need SOFTRR to starve other tasks. This is why I said
that all the issues that have been grought up in the last few months
should be discussed before going in 2.6. So that we can either say that
are corner cases that we can ive ith, or we fix them. I didn't follow the
scheduler after the first merge but it seems that a couple of issues
should be addressed before 2.6.



- Davide

