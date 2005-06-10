Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFJUB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFJUB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVFJUB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:01:57 -0400
Received: from mx1.suse.de ([195.135.220.2]:20894 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261197AbVFJUBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:01:55 -0400
Date: Fri, 10 Jun 2005 22:01:54 +0200
From: Andi Kleen <ak@suse.de>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Cc: Tom Duffy <tduffy@sun.com>, Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] [OOPS] powernow on smp dual core amd64
Message-ID: <20050610200153.GO23831@wotan.suse.de>
References: <84EA05E2CA77634C82730353CBE3A84301CFC134@SAUSEXMB1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84301CFC134@SAUSEXMB1.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 02:48:58PM -0500, Langsdorf, Mark wrote:
> It looks like the crash is caused by an invalid
> pointer dereference in 
> query_current_values_with_pending_wait(), which
> implies that powernowk8_get() was called with an
> invalid CPU number.
> 
> Andi, what will happen if you do
> set_cpus_allowed(current, cpumask_of_cpu(cpu)) when
> cpu isn't in the range of online CPUs?  There's

It just returns with -EINVAL.

Also it really shouldnt happen. 

> supposed to be a check to prevent an invalid
> pointer access from happening but it's failing for 
> some reason.
-Andi
