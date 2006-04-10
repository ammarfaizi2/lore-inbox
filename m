Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWDJG4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWDJG4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 02:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWDJG4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 02:56:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751048AbWDJG4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 02:56:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH rc1-mm 1/3] coredump: some code relocations
In-Reply-To: Oleg Nesterov's message of  Sunday, 9 April 2006 04:11:20 +0400 <20060409001120.GA98@oleg>
X-Windows: even your dog won't like it.
Message-Id: <20060410065638.EEB1F1809CB@magilla.sf.frob.com>
Date: Sun,  9 Apr 2006 23:56:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a preparation for the next patch. No functional changes.
> Basically, this patch moves '->flags & SIGNAL_GROUP_EXIT' check
> into zap_threads(), and 'complete(vfork_done)' into coredump_wait
> outside of ->mmap_sem protected area.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

I don't see anything especially wrong with these reorganizations.  I'd
prefer if the commentary for the change indicated what about them was
required for the following patches.  Making zap_threads have a return value
does seem sort of random and obfuscatory, but that is a minor nit.


Thanks,
Roland
