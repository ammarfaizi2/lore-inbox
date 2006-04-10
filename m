Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWDJHNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWDJHNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWDJHNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:13:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59619 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751065AbWDJHNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:13:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH rc1-mm 3/3] coredump: copy_process: don't check SIGNAL_GROUP_EXIT
In-Reply-To: Oleg Nesterov's message of  Sunday, 9 April 2006 04:11:30 +0400 <20060409001130.GA104@oleg>
X-Zippy-Says: If Robert Di Niro assassinates Walter Slezak, will Jodie Foster
   marry Bonzo??
Message-Id: <20060410071308.CBC4E1809D1@magilla.sf.frob.com>
Date: Mon, 10 Apr 2006 00:13:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After the previous patch SIGNAL_GROUP_EXIT implies a pending SIGKILL,
> we can remove this check from copy_process() because we already checked
> !signal_pending().

My SIGNAL_GROUP_EXEC change made this spot check for either flag, but this
already holds true for the exec case and so my change to this check here
was not needed.  With the coredump change done, I concur that the exit
cases are covered too and so this check can go.  For paranoia's sake,
perhaps we should leave behind a BUG_ON.


Thanks,
Roland
