Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752511AbWAGDB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbWAGDB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbWAGDB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:01:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:18855 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752511AbWAGDB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:01:57 -0500
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] use local_t for page statistics
Date: Sat, 7 Jan 2006 04:01:47 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20060106215332.GH8979@kvack.org> <20060106163313.38c08e37.akpm@osdl.org> <43BF2D03.2030908@yahoo.com.au>
In-Reply-To: <43BF2D03.2030908@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601070401.47618.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 03:52, Nick Piggin wrote:

> No. On many load/store architectures there is no good way to do local_t,
> so something like ppc32 or ia64 just uses all atomic operations for

well, they're just broken and need to be fixed to not do that.

Also I bet with some tricks a seqlock like setup could be made to work.

> local_t, and ppc64 uses 3 counters per-cpu thus tripling the cache
> footprint.

and ppc64 has big caches so this also shouldn't be a problem.

-Andi
