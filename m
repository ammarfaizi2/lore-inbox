Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbTGLPwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265975AbTGLPwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:52:04 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:55942 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265974AbTGLPwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:52:02 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 08:59:18 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
In-Reply-To: <20030712154942.GB9547@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
 <20030712154942.GB9547@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > With the current patch you do not need any special support if you are
> > already asking for SCHED_RR policy. If you are not root you will be
> > automatically downgraded to SCHED_SOFTRR ;)
>
> Cool.  What happens if you run two SCHED_SOFTRR tasks and they both
> use 50% of the CPU - will that starve all the other tasks?  Or is the
> CPU usage of all SOFTRR tasks bounded collectively?

Nope :) They will run their timeslice entirely and then they will try to
get some more. Looking at their last recharge timestamp, Dad scheduler
will put them in bed and will give other tasks a chance to run. But don't
worry, I am very sure there're other exploit available. I just didn't have
enough time to think about it. It is amazing how limited are things that
you can do in one hour :)



- Davide

