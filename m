Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268966AbUIHCJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbUIHCJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUIHCJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:09:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39611 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268966AbUIHCJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:09:30 -0400
Subject: Re: [patch 2/2] cpu hotplug notifier for updating sched domains
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <413E55D8.8030608@cyberone.com.au>
References: <200409071849.i87Inw3f143238@austin.ibm.com>
	 <413E55D8.8030608@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1094608996.8015.5.camel@booger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Sep 2004 21:05:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 19:44, Nick Piggin wrote:
> I think the next step is to now make the setup code only use cpu_online_map
> and get rid of everywhere I had been doing cpus_and(tmp, ..., 
> cpu_online_map).
> This may also make your patch 1/2 unnecessary? What do you think?

Well, we have to "lie" to arch_init_sched_domains a little bit when
bringing a cpu online, by setting the soon-to-be-online cpu's bit in the
argument mask.  So I think the first patch is still necessary.

Nathan


