Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVLHAg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVLHAg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVLHAg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:36:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965070AbVLHAg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:36:27 -0500
Date: Wed, 7 Dec 2005 16:37:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: paulmck@us.ibm.com, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
Message-Id: <20051207163746.46248c73.akpm@osdl.org>
In-Reply-To: <20051205110239.GE2385@in.ibm.com>
References: <20051205110239.GE2385@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> +		smp_mb();
> +		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);

Please always include a comment when adding a barrier.  Because it's often
not obvious to the reader what that barrier is actually doing.
