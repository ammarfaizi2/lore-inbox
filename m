Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVCDC1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVCDC1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVCDC12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:27:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:2731 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262009AbVCDCZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:25:37 -0500
Date: Thu, 3 Mar 2005 20:24:24 -0600
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, jgarzik@pobox.com, rene@exactcode.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, chrisw@osdl.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050304022424.GA26769@austin.ibm.com>
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com> <20050303225542.GB16886@austin.ibm.com> <20050303175951.41cda7a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303175951.41cda7a4.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 03, 2005 at 05:59:51PM -0800, Andrew Morton wrote:
> This patch doesn't seem right - current 2.6.11 has:
> 
>         return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;

The patch was against what Greg had already pushed into the
linux-release.bkbits.net 2.6.11 tree, i.e. not what's in mainline.
You're right, your revised patch would apply against mainline.

However: This patch shouldn't go to mainline, since
ppc-ppc64-abstract-cpu_feature-checks.patch in your tree takes care of
the problem. I'd like the abstraction/cleanup patch to be merged upstream
instead of the #ifdef hack once the tree opens up.


Thanks,

-Olof
