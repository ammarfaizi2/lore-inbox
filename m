Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUHXGDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUHXGDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUHXGDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:03:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59614 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265722AbUHXGCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:02:54 -0400
Date: Tue, 24 Aug 2004 08:03:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
Message-ID: <20040824060341.GA30594@elte.hu>
References: <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu> <20040823210151.GA10949@elte.hu> <1093312154.862.17.camel@krustophenia.net> <20040824054128.GA29027@elte.hu> <1093326406.817.7.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093326406.817.7.camel@krustophenia.net>
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

> > it has an effect on input queue length. Output queue lengths can be
> > reduced via 'ifconfig eth0 txqueuelen 8'.
> 
> OK.  With both of these set to 4, the largest latency I was able to
> generate by ping flooding was 253 usecs.
> 
> Is there any particular reason one of these parameters is set via a
> sysctl/proc entry, and one by ifconfig?

well, the input packet backlog is global, the output one is local. No
good reason otherwise.

	Ingo
