Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272685AbTHKOpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272686AbTHKOpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:45:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S272685AbTHKOo5 (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 11 Aug 2003 10:44:57 -0400
Message-Id: <5.2.1.1.2.20030811163616.01983b68@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 11 Aug 2003 16:49:02 +0200
To: root@chaos.analogic.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: volatile variable
Cc: David Woodhouse <dwmw2@infradead.org>,
       Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>,
       mlist-linux-kernel@nntp-server.caltech.edu
In-Reply-To: <Pine.LNX.4.53.0308110944350.17240@chaos>
References: <1060608783.19194.13.camel@passion.cambridge.redhat.com>
 <20030801105706.30523.qmail@webmail28.rediffmail.com>
 <Pine.LNX.4.53.0308010723060.3077@chaos>
 <1060608783.19194.13.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:06 AM 8/11/2003 -0400, Richard B. Johnson wrote:
>On Mon, 11 Aug 2003, David Woodhouse wrote:
>
> > On Fri, 2003-08-01 at 12:38, Richard B. Johnson wrote:
> > > First, there are already procedures available to do just
> > > what you seem to want to do, interruptible_sleep_on() and
> > > interruptible_sleep_on_timeout(). These take care of the
> > > ugly details that can trip up compilers.
> >
> > Just in case there are people reading this who don't realise that
> > Richard is trolling -- do not ever use sleep_on() and friends. They
> > _will_ introduce bugs, and hence they _will_ be removed from the kernel
> > some time in the (hopefully not-so-distant) future.
> >
>
>The linux-2.4.20 contains 516 references to "sleep_on" in the
>`drivers` tree. This is hardly a function or macro that will
>be removed. If there are bugs, they will be fixed, not removed.

They've been declared dead since (grep 'DO NOT use them' patch*) 
2.5.48.  See include/linux/wait.h for details.

         -Mike


