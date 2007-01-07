Return-Path: <linux-kernel-owner+w=401wt.eu-S932496AbXAGLAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbXAGLAW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 06:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbXAGLAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 06:00:22 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:33129 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496AbXAGLAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 06:00:21 -0500
Date: Sun, 7 Jan 2007 16:30:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070107110013.GD13579@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106111117.54bb2307.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 11:11:17AM -0800, Andrew Morton wrote:
> Has anyone thought seriously about using the process freezer in the
> cpu-down/cpu-up paths?  That way we don't need to lock anything anywhere?

How would this provide a stable access to cpu_online_map in functions
that need to block while accessing it (as flush_workqueue requires)?

-- 
Regards,
vatsa
