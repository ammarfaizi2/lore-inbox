Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbULGW7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbULGW7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbULGW7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 17:59:30 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:27802 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261968AbULGW7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 17:59:15 -0500
Message-ID: <41B635BC.9050609@cyberone.com.au>
Date: Wed, 08 Dec 2004 09:59:08 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Dimitri Sivanich <sivanich@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH] isolcpus option broken in 2.6.10-rc2-bk2
References: <20041206185221.GA23917@sgi.com>
In-Reply-To: <20041206185221.GA23917@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dimitri Sivanich wrote:

>The isolcpus option is broken in 2.6.10-rc2-bk2.  The domains are no longer
>being properly initialized (which results in a panic at bootup).
>
>The following patch fixes this.
>
>Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>
>

Sorry for not replying earlier, I've been away for a few days.

I don't think this is quite needed, because isolated CPUs should
have their domain set to sched_domain_dummy, I think?

The trick would be to just initialise sched_domain_dummy properly;
it looks like that isn't being done for some reason.

Give me a couple of hours and I'll try testing something that
should solve it.


