Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUHTHbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUHTHbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUHTHbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:31:25 -0400
Received: from dns1.seagha.com ([217.66.0.18]:14055 "EHLO ndns1.seagha.com")
	by vger.kernel.org with ESMTP id S263540AbUHTHbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:31:23 -0400
Message-ID: <6DED3619289CD311BCEB00508B8E133601A68AE6@nt-server2.antwerp.seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
To: "'Lee Revell'" <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [patch] voluntary-preempt-2.6.8.1-P4
Date: Fri, 20 Aug 2004 09:32:25 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2004-08-19 at 16:37, karl.vogel@seagha.com wrote:
> > The following latency trace is generated each time the 
> sound driver is opened
> > by an application on my box.
> > 
> 
> This is a pretty big trace.  Please try to trim these, especially if a
> few lines repeat hundreds of times (common).

Point taken.. I'll blame the 21'' for not noticing the length :)

> The comment seems to imply that the author didn't like the 
> mdelay but it
> didn't work otherwise.  What happens if you get rid of the mdelay?
> 
> Lee

The author didn't like it, but he still put it in, so there must
be a very good reason for it, no? Anyway I will try it out this
evening.

The code also indicates that it is to reset back to 2 channel mode, 
but my notebook only has 2 output channels - so in my case I can
probably skip the entire code snippet.

I'm not a kernel hacker, but I wonder if a lock around the driver
initialisation wouldn't allow it to run with preemption turned on?

Karl.
