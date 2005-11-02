Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbVKBUqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbVKBUqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbVKBUqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:46:10 -0500
Received: from gold.veritas.com ([143.127.12.110]:33409 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965233AbVKBUqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:46:09 -0500
Date: Wed, 2 Nov 2005 20:45:03 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Blaisorblade <blaisorblade@yahoo.it>
cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org, dvhltc@us.ibm.com,
       linux-mm <linux-mm@kvack.org>, Jeff Dike <jdike@addtoit.com>
Subject: Re: New bug in patch and existing Linux code - race with install_page()
 (was: Re: [PATCH] 2.6.14 patch for supporting madvise(MADV_REMOVE))
In-Reply-To: <Pine.LNX.4.61.0511022003070.17607@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511022043240.17907@goblin.wat.veritas.com>
References: <1130366995.23729.38.camel@localhost.localdomain>
 <20051102014321.GG24051@opteron.random> <1130947957.24503.70.camel@localhost.localdomain>
 <200511022054.15119.blaisorblade@yahoo.it> <Pine.LNX.4.61.0511022003070.17607@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Nov 2005 20:46:08.0903 (UTC) FILETIME=[73DD7170:01C5DFEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Hugh Dickins wrote:
> On Wed, 2 Nov 2005, Blaisorblade wrote:
> 
> No, it should be fine as is (unless perhaps some barrier is needed).

We already have the barrier needed: we're holding page_table_lock (pte lock).

Hugh
