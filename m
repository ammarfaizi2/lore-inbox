Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVCDGGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVCDGGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVCDGGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:06:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64995 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261479AbVCDGGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:06:42 -0500
Message-ID: <4227FADD.30905@pobox.com>
Date: Fri, 04 Mar 2005 01:06:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Olof Johansson <olof@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, rene@exactcode.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <16935.36862.137151.499468@cargo.ozlabs.ibm.com> <20050303225542.GB16886@austin.ibm.com> <20050303175951.41cda7a4.akpm@osdl.org> <20050304022424.GA26769@austin.ibm.com> <20050304055451.GN5389@shell0.pdx.osdl.net>
In-Reply-To: <20050304055451.GN5389@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Olof Johansson (olof@austin.ibm.com) wrote:
> 
>>Hi,
>>
>>On Thu, Mar 03, 2005 at 05:59:51PM -0800, Andrew Morton wrote:
>>
>>>This patch doesn't seem right - current 2.6.11 has:
>>>
>>>        return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
>>
>>The patch was against what Greg had already pushed into the
>>linux-release.bkbits.net 2.6.11 tree, i.e. not what's in mainline.
>>You're right, your revised patch would apply against mainline.
>>
>>However: This patch shouldn't go to mainline, since
>>ppc-ppc64-abstract-cpu_feature-checks.patch in your tree takes care of
>>the problem. I'd like the abstraction/cleanup patch to be merged upstream
>>instead of the #ifdef hack once the tree opens up.
> 
> 
> Olof's patch is in the linux-release tree, so this brings up a point
> regarding merging.  If the quick fix is to be replaced by a better fix
> later (as in this case) there's some room for merge conflict.  Does this
> pose a problem for either -mm or Linus' tree?

Just need to make sure <whomever> aware of this, when you push to Linus.

In most cases, of dire fixes, they should just go into linux-release, 
and then get pulled into linux-2.6.

For a few cases, like this one, the quick fix will hit linux-release and 
linux-2.6 before the better fix, so no big deal.

In a few rare cases, you will need to create a "for-upstream" tree that 
handles the conflict before it get pushed to Linus.

	Jeff


