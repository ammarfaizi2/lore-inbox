Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWI1EWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWI1EWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWI1EWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:22:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51588 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750789AbWI1EWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:22:44 -0400
From: Neil Brown <neilb@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Date: Thu, 28 Sep 2006 14:22:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17691.19982.162616.572205@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 009 of 11] knfsd: Allow max size of NFSd payload
	to be configured.
In-Reply-To: message from J. Bruce Fields on Monday September 25
References: <20060824162917.3600.patches@notabene>
	<1060824063716.5020@suse.de>
	<20060925212457.GK32762@fieldses.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 25, bfields@fieldses.org wrote:
> 
> It looks to me like totalram is actually measured in pages.  So in
> practice this gives almost everyone 8k here.  So that 12 should be
> something like 12 - PAGE_CACHE_SHIFT?

Uhm.... yes.  Thanks.
But are the pages that totalram is measure in, normal pages, of
page_cache pages?  And is there a difference?
Should we use PAGE_CACHE_SHIFT, or PAGE_SHIFT?
And why do we have both if they are numerically identical?

I'll submit a patch which uses
        12 - PAGE_SHIFT
in a little while.

Thanks,
NeilBrown
