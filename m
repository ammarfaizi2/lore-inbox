Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVCYIcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVCYIcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 03:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVCYIcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 03:32:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47059 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261546AbVCYIcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 03:32:31 -0500
Date: Fri, 25 Mar 2005 09:32:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU scheduler tests
Message-ID: <20050325083224.GA23407@elte.hu>
References: <4243C243.10401@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4243C243.10401@sw.ru>
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


* Kirill Korotaev <dev@sw.ru> wrote:

> Can someone (Ingo?) recommend me CPU scheduler tests which are usually 
> used to test CPU scheduler perfomance, context switch performance, 
> SMP/migration/balancing performance etc.?

it's not really the microbenchmarks that matter (although they obviously 
are part of the picture), but actual application performance. There are 
dozens of workloads that matter. Kernel compilation timings are an 
obvious priority :-), but there are other things like SPECsdet, STREAM, 
dbt3-pgsql, kernbench, AIM7, various Java benchmarks and more.

now that scheduler changes have calmed down somewhat, we are mainly 
looking for regressions, and are checking schedstats output to see how 
'healthy' a given workload behaves.

	Ingo
