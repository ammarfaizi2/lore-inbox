Return-Path: <linux-kernel-owner+w=401wt.eu-S1030308AbXAEJDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbXAEJDw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbXAEJDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:03:52 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:39343 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030308AbXAEJDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:03:50 -0500
Date: Fri, 5 Jan 2007 14:33:47 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070105090347.GC18088@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070104180901.GA344@tv-sign.ru> <20070104103107.e33768d7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104103107.e33768d7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 10:31:07AM -0800, Andrew Morton wrote:
> But before we do much more of this we should have a wrapper.  Umm
> 
> static inline void block_cpu_hotplug(void)
> {
> 	preempt_disable();
> }

Nack.

This will only block cpu down, not cpu_up and hence is a misnomer. I would be 
vary of ignoring cpu_up events totally in writing hotplug safe code.

-- 
Regards,
vatsa
