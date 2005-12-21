Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVLUNVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVLUNVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVLUNVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:21:45 -0500
Received: from pat.uio.no ([129.240.130.16]:30410 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932402AbVLUNVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:21:44 -0500
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client
	on	interactive response
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43A8F714.4020406@bigpond.net.au>
References: <43A8EF87.1080108@bigpond.net.au>
	 <1135145341.7910.17.camel@lade.trondhjem.org>
	 <43A8F714.4020406@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 08:21:20 -0500
Message-Id: <1135171280.7958.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.044, required 12,
	autolearn=disabled, AWL 1.77, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-21 at 17:32 +1100, Peter Williams wrote:

> > Sorry. That theory is just plain wrong. ALL of those case _ARE_
> > interactive sleeps.
> 
> It's not a theory.  It's a result of observing a -j 16 build with the 
> sources on an NFS mounted file system with top with and without the 
> patches and comparing that with the same builds with the sources on a 
> local file system.  Without the patches the tasks in the kernel build 
> all get the same dynamic priority as the X server and other interactive 
> programs when the sources are on an NFS mounted file system.  With the 
> patches they generally have dynamic priorities between 6 to 10 higher 
> than the X server and other interactive programs.

...and if you stick in a faster server?...

There is _NO_ fundamental difference between NFS and a local filesystem
that warrants marking one as "interactive" and the other as
"noninteractive". What you are basically saying is that all I/O should
be marked as TASK_NONINTERACTIVE.

Cheers,
  Trond

