Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbUKEKVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUKEKVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUKEKVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:21:10 -0500
Received: from mx1.elte.hu ([157.181.1.137]:58343 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261541AbUKEKVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:21:02 -0500
Date: Fri, 5 Nov 2004 11:22:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105102204.GA4730@elte.hu>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411051041.17940.l_allegrucci@yahoo.it>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:

> On Friday 05 November 2004 09:13, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/
> 
> ------------[ cut here ]------------
> kernel BUG at mm/memory.c:156!

> Process shmt04 (pid: 4854, threadinfo=dca51000 task=de374510)

reproducible here too, just running LTP's shmt04 directly triggers it
immediately. Looks like there's interaction of 4-level pagetables with
ipc/shm.c or mm/shmem.c.

	Ingo
