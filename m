Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUKBPK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUKBPK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUKBN5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:57:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25770 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262089AbUKBNKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:10:00 -0500
Date: Tue, 2 Nov 2004 14:11:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] optional non-interactive mode for cpu scheduler
Message-ID: <20041102131105.GA17535@elte.hu>
References: <41871BA7.6070300@kolivas.org> <20041102125218.GH15290@elte.hu> <4187854C.6000803@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4187854C.6000803@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> However the non-interactive mode addresses a number of different needs 
> that seem to have come up. Specifically:
> I have had users report great success with such a mode on my own 
> scheduler in multiple X session setups where very choppy behaviour 
> occurs in mainline.

since SCHED_CPUBOUND would be inherited across fork(), it should be
rather easy to start an X session with all tasks as SCHED_CPUBOUND.

but i think the above rather points in the direction of some genuine
weakness in the interactivity code (i know, for which the fix is
staircase ;) which would be nice to debug.

> Many high performance computing people do not wish interactivity code
> modifying their choice of latency/distribution - admittedly this is a
> soft one.

well, SCHED_CPUBOUND would solve their needs too, right?

	Ingo
