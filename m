Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTIICdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTIICdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:33:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:1922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263884AbTIICdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:33:04 -0400
Date: Mon, 8 Sep 2003 19:33:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: slpratt@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Message-Id: <20030908193344.157962b8.akpm@osdl.org>
In-Reply-To: <200309091231.48709.kernel@kolivas.org>
References: <3F5D023A.5090405@austin.ibm.com>
	<200309091210.06333.kernel@kolivas.org>
	<200309091216.32964.kernel@kolivas.org>
	<200309091231.48709.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> > Correction sorry: These changes were due to
>  > sched-CAN_MIGRATE_TASK-fix.patch and the test results say
>  > volano-results-2.6.0-test5-A0-*
> 
>  Further testing shows the patch: sched-balance-fix-2.6.0-test3-mm3-A0.patch to 
>  have no effect on volano results by itself. 

OK, thanks.

As I have just learnt that volanomark is dominated by sched_yield()-based
userspace locking I have suddenly lost all interest in it.  We don't want
to tune the kernel for braindead locking implementations.  Call me when it
has been converted to futexes ;)

Do we know what specjbb is doing internally?


