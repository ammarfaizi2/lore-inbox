Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbVF3Q5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVF3Q5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVF3Q4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:56:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10112 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263011AbVF3Q40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:56:26 -0400
Date: Thu, 30 Jun 2005 18:55:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050630165557.GA15692@elte.hu>
References: <42C320C4.9000302@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C320C4.9000302@opersys.com>
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


* Kristian Benoit <kbenoit@opersys.com> wrote:

> "plain" run:
> 
> Measurements   |   Vanilla   |  preemp_rt     |
> ---------------+-------------+----------------+
> fork           |      93us   |  157us (+69%)  |
> open/close     |     2.3us   |  3.7us (+43%)  |
> execve         |     351us   |  446us (+27%)  |
> select 500fd   |    12.7us   | 25.8us (+103%) |
> mmap           |     660us   | 2867us (+334%) |
> pipe           |     7.1us   | 11.6us (+63%)  |

update: these tests should perform significantly better on the freshly 
released -50-37 (or later) PREEMPT_RT kernels. (fork, execve, mmap [*] 
was improved in -50-36, the others in -50-37)

	Ingo

[*] the extent of the above fork/execve/mmap costs is still unexplained, 
    unless the test was run with HIGHMEM64 and HIGHPTE enabled.
