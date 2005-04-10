Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVDJK17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVDJK17 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 06:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVDJK17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 06:27:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29114 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261465AbVDJK15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 06:27:57 -0400
Date: Sun, 10 Apr 2005 12:27:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 'BUG: scheduling with irqs disabled' when umounting NFS volume
Message-ID: <20050410102735.GA4490@elte.hu>
References: <1112991311.11000.37.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112991311.11000.37.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Kernel is 2.6.12-rc1-RT-V0.7.43-05.
> 
> BUG: scheduling with irqs disabled: umount/0x00000000/20612
> caller is schedule_timeout+0x63/0xc0
>  [<c01033d3>] dump_stack+0x23/0x30 (20)
>  [<c02b4f5a>] schedule+0xea/0x140 (36)
>  [<c02b5b23>] schedule_timeout+0x63/0xc0 (64)
>  [<c02b5744>] interruptible_sleep_on_timeout+0x74/0xe0 (64)
>  [<c01cf898>] lockd_down+0xb8/0x140 (24)
>  [<c01c2137>] nfs_kill_super+0x77/0x80 (16)
>  [<c016033c>] deactivate_super+0x8c/0xb0 (28)
>  [<c0178bc1>] sys_umount+0x41/0x90 (88)
>  [<c0178c2e>] sys_oldumount+0x1e/0x20 (16)
>  [<c0102dee>] syscall_call+0x7/0xb (-8124)

i've uploaded the -44-04 kernel, which should fix this bug.

	Ingo
