Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUHJItI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUHJItI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUHJItI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:49:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15297 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262932AbUHJIsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:48:23 -0400
Date: Tue, 10 Aug 2004 10:49:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810084902.GB26081@elte.hu>
References: <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092103522.761.2.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

>  [<c013e2ee>] do_anonymous_page+0x7e/0x190
>  [<c013e44e>] do_no_page+0x4e/0x310
>  [<c013e8d1>] handle_mm_fault+0xc1/0x170
>  [<c013d2a0>] get_user_pages+0x130/0x3b0
>  [<c013ea28>] make_pages_present+0x68/0x90
>  [<c01401d8>] do_mmap_pgoff+0x3f8/0x640
>  [<c010b656>] sys_mmap2+0x76/0xb0

could you turn off CONFIG_HIGHMEM altogether? Can you still reproduce
this mlockall() latency?

	Ingo
