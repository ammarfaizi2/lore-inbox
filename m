Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbUJWURL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbUJWURL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUJWURK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:17:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56044 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261266AbUJWUQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:16:56 -0400
Date: Sat, 23 Oct 2004 22:17:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com,
       Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041023201724.GA23936@elte.hu>
References: <20041023194721.GB1268@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023194721.GB1268@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> +	bool "Reserve a CPU for hard realtime processes"

this has been implemented in a clean way already: check out the
"isolcpus=" boot option & scheduler feature (implemented by Dimitri
Sivanich) which isolates a set of CPUs via sched-domains for precisely
such purposes. The way to enter such a domain is via the affinity
syscall - and balancing will leave such domains isolated.

	ingo
