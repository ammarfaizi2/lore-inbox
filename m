Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbVKGVso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbVKGVso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVKGVso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:48:44 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37267 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965121AbVKGVsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:48:42 -0500
Subject: Re: [RFC 2/2] Hugetlb COW
From: Adam Litke <agl@us.ibm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
       hugh@veritas.com, rohit.seth@intel.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org
In-Reply-To: <1131399533.25133.104.camel@localhost.localdomain>
References: <1131397841.25133.90.camel@localhost.localdomain>
	 <1131399533.25133.104.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Mon, 07 Nov 2005 15:47:55 -0600
Message-Id: <1131400076.25133.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 15:38 -0600, Adam Litke wrote:
> [RFC] COW for hugepages
> (Patch originally from David Gibson <dwg@au1.ibm.com>)
> 
> This patch implements copy-on-write for hugepages, hence allowing
> MAP_PRIVATE mappings of hugetlbfs.
> 
> This is chiefly useful for cases where we want to use hugepages
> "automatically" - that is to map hugepages without the knowledge of
> the code in the final application (either via kernel hooks, or with
> LD_PRELOAD).  We can use various heuristics to determine when
> hugepages might be a good idea, but changing the semantics of
> anonymous memory from MAP_PRIVATE to MAP_SHARED without the app's
> knowledge is clearly wrong.

I forgot to mention in the original post that this patch is currently
broken on ppc64 due to a problem with update_mmu_cache().  The proper
fix is understood but backed up behind the powerpc merge activity.  

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

