Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUHTI7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUHTI7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUHTI6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:58:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58594 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268122AbUHTIwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:52:08 -0400
Date: Fri, 20 Aug 2004 13:59:41 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm2
Message-ID: <20040820082941.GA31649@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040819014204.2d412e9b.akpm@osdl.org> <1092964083.4946.7.camel@biclops.private.network> <20040819181603.700a9a0e.akpm@osdl.org> <1092987650.28849.349.camel@bach> <20040820081458.GA4949@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820081458.GA4949@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 10:14:58AM +0200, Ingo Molnar wrote:
> no! this removes the whole performance optimization of self-reaping and
> re-introduces the context-switches. Just measure the
> creation/destruction performance of threads. Strong NACK.

Is it possible to modify release_task to not remove self-reaping tasks
from the list (and possibly have it removed during finish_task_switch)?

This should solve the hotplug race as well as keep the current optimization?

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
