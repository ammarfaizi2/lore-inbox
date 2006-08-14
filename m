Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752030AbWHNPF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbWHNPF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWHNPF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:05:26 -0400
Received: from mx2.redhat.com ([66.187.237.31]:44996 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S1751995AbWHNPFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:05:25 -0400
Date: Mon, 14 Aug 2006 16:05:09 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Kobras <kobras@linux.de>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] Re: [PATCH] dm: Fix deadlock under high i/o load in raid1 setup.
Message-ID: <20060814150509.GO18633@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Daniel Kobras <kobras@linux.de>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org
References: <20060809164421.GC9984@antares.tat.physik.uni-tuebingen.de> <20060812130228.f7954b5f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060812130228.f7954b5f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 01:02:28PM -0700, Andrew Morton wrote:
> Alasdair, I'd say that this is a 2.6.18 fix and a 2.6.17.x backport.
 
Yes.

> Or move the mempool_free()ing out of kmorrord context and into
> IO-completion context, perhaps.

That's how some other dm targets handle this particular problem.
 
Alasdair
-- 
agk@redhat.com
