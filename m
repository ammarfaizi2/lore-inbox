Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUKFLhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUKFLhX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 06:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbUKFLhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 06:37:23 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:62612 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261371AbUKFLhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 06:37:13 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16780.46945.925271.26168@thebsh.namesys.com>
Date: Sat, 6 Nov 2004 14:37:05 +0300
To: Andrea Arcangeli <andrea@novell.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
In-Reply-To: <20041106015051.GU8229@dualathlon.random>
References: <20041105200118.GA20321@logos.cnet>
	<200411051532.51150.jbarnes@sgi.com>
	<20041106012018.GT8229@dualathlon.random>
	<418C2861.6030501@cyberone.com.au>
	<20041106015051.GU8229@dualathlon.random>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
 > On Sat, Nov 06, 2004 at 12:26:57PM +1100, Nick Piggin wrote:
 > > need to be performed and have no failure path. For example __GFP_REPEAT.
 > 
 > all allocations should have a failure path to avoid deadlocks. But in

This is not currently possible for a complex operation that allocates
multiple pages and has always complete as a whole.

We need page-reservation API of some sort. There were several attempts
to introduce this, but none get into mainline.

Nikita.
