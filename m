Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVLUQMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVLUQMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVLUQMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:12:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1460 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932378AbVLUQMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:12:09 -0500
Date: Wed, 21 Dec 2005 17:11:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on	interactive response
Message-ID: <20051221161140.GA7950@elte.hu>
References: <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A8F714.4020406@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> It's not a theory.  It's a result of observing a -j 16 build with the 
> sources on an NFS mounted file system with top with and without the 
> patches and comparing that with the same builds with the sources on a 
> local file system. [...]

could you try the build with the scheduler queue from -mm, and set the 
shell to SCHED_BATCH first? Do you still see interactivity problems 
after that?

i'm not sure we want to override the scheduling patterns observed by the 
kernel, via TASK_NONINTERACTIVE - apart of a few obvious cases.

	Ingo
