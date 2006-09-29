Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWI2Pn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWI2Pn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 11:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWI2Pn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 11:43:27 -0400
Received: from smtp-out.google.com ([216.239.45.12]:6374 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932286AbWI2PnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 11:43:25 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=XzUyCVKhxRjt+oBkUWJ6LaP7lwO77siuJv+9r3QUkZ6ivLrAHQEAHk97I7LPWvRBx
	98iV5mqwErsVTm0Il966Q==
Message-ID: <6599ad830609290843t7b2c1499r13f8a2aef6f0611c@mail.google.com>
Date: Fri, 29 Sep 2006 08:43:20 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC][PATCH 0/4] Generic container system
Cc: sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, dev@sw.ru, mbligh@google.com,
       winget@google.com, rohitseth@google.com
In-Reply-To: <20060928213111.c881195c.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060928104035.840699000@menage.corp.google.com>
	 <20060928213111.c881195c.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/06, Paul Jackson <pj@sgi.com> wrote:
>
> Apparently some generic code in kernel/sched.c is using cpuacct_charge,
> but cpuacct_charge is only defined if CONFIG_CONTAINER_CPUACCT is
> enabled.  Perhaps you need an empty stub for cpuacct_charge in
> cpu_acct.h, in the event that CONTAINER_CPUACCT is not enabled.

You're right, the cpu_acct patch was a late example addition and I
forgot to compile with CONFIG_CONTAINER_CPUACCT disabled ...

>
> Looks like cpuset_subsys doesn't know if it is extern or static,
> and container_cs() is a cast thingie, which isn't allowed on the
> left side in modern gcc.

It builds fine on gcc 3.2.2, which is still a supported compiler
according to Documentation/Changes - maybe that's a bit out of date?

Paul
