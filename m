Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVBQUNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVBQUNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVBQUNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:13:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63136 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262328AbVBQULx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:11:53 -0500
Date: Thu, 17 Feb 2005 21:11:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Philippe Elie <phil.el@wanadoo.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
Message-ID: <20050217201145.GA14706@elte.hu>
References: <1108274835.3739.2.camel@krustophenia.net> <20050213130058.GA566@zaniah> <20050213133020.GA16363@elte.hu> <1108670727.11411.6.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108670727.11411.6.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> I noticed profiling the kernel with PREEMPT_DESKTOP that mcount and
> __mcount add quite a bit of overhead.  Something like .5% CPU each.
> Sorry, I didn't save the oprofile output.
> 
> So, disable CONFIG_MCOUNT if you want minimal overhead from the RT
> patches.  IIRC it was previously stated that the latency tracing
> overhead could be mostly avoided by disabling it at runtime.

yes - most of the overhead can be disabled, but not all. 1% CPU time
might sound alot but when compared against 10% (or more) tracing
overehad it's small. The least overhead comes from disabling tracing in
the .config.

	Ingo
