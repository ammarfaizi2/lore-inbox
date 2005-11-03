Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVKCOXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVKCOXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVKCOXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:23:33 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:60480 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750707AbVKCOXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:23:32 -0500
Date: Thu, 3 Nov 2005 16:22:50 +0200
From: Gleb Natapov <gleb@minantech.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051103142250.GA15202@minantech.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au> <4368139A.30701@vc.cvut.cz> <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com> <1130965454.20136.50.camel@gaston> <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com> <1130967936.20136.65.camel@gaston> <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com> <20051103081213.GC22185@minantech.com> <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com>
X-OriginalArrivalTime: 03 Nov 2005 14:23:31.0236 (UTC) FILETIME=[2A713640:01C5E082]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 02:11:46PM +0000, Hugh Dickins wrote:
> In the time since we discussed before, I've rather come full circle
> round to my original position: abandoning such ideas of trying to
> handle it from get_user_pages itself, appreciating the simplicity
> of the original PROT_DONTCOPY idea from you guys; but sticking to my
> initial reaction that this is better done by madvise(MADV_DONTCOPY),
> not by the mmap/mprotect route in Michael's patch.  (I never bought
> the "racy" argument advanced in favour of the mmap flag.)
> 
Excellent! Then DONTCOPY it will be.

--
			Gleb.
