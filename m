Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVCDFzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVCDFzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVCDFzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:55:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:24992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261520AbVCDFzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 00:55:08 -0500
Date: Thu, 3 Mar 2005 21:54:51 -0800
From: Chris Wright <chrisw@osdl.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, paulus@samba.org, jgarzik@pobox.com,
       rene@exactcode.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       greg@kroah.com, chrisw@osdl.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050304055451.GN5389@shell0.pdx.osdl.net>
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com> <20050303225542.GB16886@austin.ibm.com> <20050303175951.41cda7a4.akpm@osdl.org> <20050304022424.GA26769@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304022424.GA26769@austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Olof Johansson (olof@austin.ibm.com) wrote:
> Hi,
> 
> On Thu, Mar 03, 2005 at 05:59:51PM -0800, Andrew Morton wrote:
> > This patch doesn't seem right - current 2.6.11 has:
> > 
> >         return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
> 
> The patch was against what Greg had already pushed into the
> linux-release.bkbits.net 2.6.11 tree, i.e. not what's in mainline.
> You're right, your revised patch would apply against mainline.
> 
> However: This patch shouldn't go to mainline, since
> ppc-ppc64-abstract-cpu_feature-checks.patch in your tree takes care of
> the problem. I'd like the abstraction/cleanup patch to be merged upstream
> instead of the #ifdef hack once the tree opens up.

Olof's patch is in the linux-release tree, so this brings up a point
regarding merging.  If the quick fix is to be replaced by a better fix
later (as in this case) there's some room for merge conflict.  Does this
pose a problem for either -mm or Linus' tree?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
