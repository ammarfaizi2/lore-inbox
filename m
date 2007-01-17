Return-Path: <linux-kernel-owner+w=401wt.eu-S932567AbXAQQZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbXAQQZM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbXAQQZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:25:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:41490 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567AbXAQQZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:25:10 -0500
Date: Wed, 17 Jan 2007 21:55:01 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070117162501.GF26211@in.ibm.com>
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
> Btw, I agree it is good to have a sleeping lock to protect cpu_online_map.
> But it should be separate from workqueue_mutex, and it is not needed for
> create/destroy/flush funcs.

Which is what lock_cpu_hotplug() attempted to provide but which
has recd lot of flak in recent days. I guess if someone implements
process freezer based locking of cpu_online_map, we will know better how 
suited later is for cpu hotplug.

-- 
Regards,
vatsa
