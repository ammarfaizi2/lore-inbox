Return-Path: <linux-kernel-owner+w=401wt.eu-S932544AbXAQQMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbXAQQMY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbXAQQMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:12:24 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:55720 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544AbXAQQMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:12:23 -0500
Date: Wed, 17 Jan 2007 21:42:07 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070117161207.GE26211@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070109165655.GA215@tv-sign.ru> <20070114235410.GA6165@tv-sign.ru> <20070115043304.GA16435@in.ibm.com> <20070115125401.GA134@tv-sign.ru> <20070115161810.GB16435@in.ibm.com> <20070115165516.GA254@tv-sign.ru> <20070116052606.GA995@in.ibm.com> <20070116132725.GA81@tv-sign.ru> <20070117061705.GB2803@in.ibm.com> <20070117154716.GA104@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117154716.GA104@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 06:47:16PM +0300, Oleg Nesterov wrote:
> > What do you mean by "currently" executing work? worker thread executing
> > some work on the cpu? That is not possible, because all threads are
> > frozen at this point. There cant be any ongoing flush_workxxx() as well
> > because of this, which should avoid breaking flush_workxxx() ..
> 
> work->func() sleeps/freezed. 

Didnt Andrew call that (work->func calling try_to_freeze) madness?

	http://lkml.org/lkml/2007/01/07/166

Does that happen in practice?

-- 
Regards,
vatsa
