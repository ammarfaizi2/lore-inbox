Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUIHEbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUIHEbi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 00:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268866AbUIHEbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 00:31:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63125 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268182AbUIHEat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 00:30:49 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] SN2 build fix CONFIG_VIRTUAL_MEM_MAP and CONFIG_DISCONTIGMEM
Date: Tue, 7 Sep 2004 21:30:38 -0700
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>, Tony Luck <tony.luck@intel.com>,
       ianw@gelato.unsw.edu.au, William Irwin <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
References: <20040905211837.3068.64652.58313@sam.engr.sgi.com>
In-Reply-To: <20040905211837.3068.64652.58313@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409072130.38480.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 5, 2004 2:18 pm, Paul Jackson wrote:
> The change on 2004-09-03 by ianw@gelato.unsw.edu.au appears to have
> a typo, which causes builds of configurations which define both
> CONFIG_VIRTUAL_MEM_MAP and CONFIG_DISCONTIGMEM to emit some 890
> warnings for redefines of each of pfn_valid, page_to_pfn,
> pfn_to_page.  This shows up compiling sn2_defconfig, the SN2
> config of arch ia64.  I believe that this is a simply typo,
> an extra "#else" line.  Removing this exta line enables sn2_defconfig
> to build as before.  Builds of other arch's untested.  No effort
> made to boot this.
>
> Signed-off-by: Paul Jackson <pj@sgi.com>

Thanks Paul, this looks a little simpler than the patch I posted (I'd rather 
just make CONFIG_DISCONTIGMEM and CONFIG_VIRTUAL_MEMMAP mandatory on ia64, 
but that's for another patch).  Linus, since this breakage is in your tree 
now, can you please apply this assuming Tony has no complaints so that people 
can build on ia64 again?

Thanks,
Jesse
