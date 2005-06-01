Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVFAJOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVFAJOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVFAJOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:14:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:206 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261345AbVFAJOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:14:10 -0400
Date: Wed, 1 Jun 2005 11:13:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
Message-ID: <20050601091344.GB11703@elte.hu>
References: <200505302141.31731.kernel-stuff@comcast.net> <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net> <429C530E.70704@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C530E.70704@stud.feec.vutbr.cz>
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


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Parag Warudkar wrote:
> >  CC      kernel/latency.o
> >kernel/latency.c:854: error: `NR_syscalls' undeclared here (not in a 
> >function)
> >
> >x86_64 doesn't seem to be defining NR_syscalls anywhere.. Shouldn't it be 
> >part of unistd.h as other arches do?
> 
> I noticed that error too. AFAIK this is not a new error in -RT, 
> latency.o never compiled on x86_64 for me. For now just disable 
> Latency tracing (CONFIG_LATENCY_TRACE).

indeed it was broken - i fixed x64 LATENCY_TRACE in the -47-16 kernel.

	Ingo
