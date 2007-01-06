Return-Path: <linux-kernel-owner+w=401wt.eu-S932185AbXAFUzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbXAFUzP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbXAFUzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:55:14 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:58424 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbXAFUzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:55:13 -0500
Message-ID: <45A00CB0.2020509@vmware.com>
Date: Sat, 06 Jan 2007 12:55:12 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] paravirt: isolate module ops
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com>	 <1168064710.20372.28.camel@localhost.localdomain>	 <20070106070807.GA11232@elte.hu> <1168105353.20372.39.camel@localhost.localdomain>
In-Reply-To: <1168105353.20372.39.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>
> +int paravirt_write_msr(unsigned int msr, u64 val);

If binary modules using debug registers makes us nervous, the 
reprogramming MSRs is also similarly bad.


> +void raw_safe_halt(void);
> +void halt(void);
>   

These shouldn't be done by modules, ever.  Only the scheduler should 
decide to halt.
