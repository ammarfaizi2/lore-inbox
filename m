Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVCCTfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVCCTfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVCCTfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:35:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:43208 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262564AbVCCStV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:49:21 -0500
Date: Thu, 3 Mar 2005 10:48:52 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Rene Rebe <rene@exactcode.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050303184852.GA12874@kroah.com>
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422756DC.6000405@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 01:26:36PM -0500, Jeff Garzik wrote:
> Rene Rebe wrote:
> >Hi,
> >
> >
> >--- linux-2.6.11/drivers/md/raid6altivec.uc.vanilla    2005-03-02 
> >16:44:56.407107752 +0100
> >+++ linux-2.6.11/drivers/md/raid6altivec.uc    2005-03-02 
> >16:45:22.424152560 +0100
> >@@ -108,7 +108,7 @@
> > int raid6_have_altivec(void)
> > {
> >     /* This assumes either all CPUs have Altivec or none does */
> >-    return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
> >+    return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
> 
> 
> I nominate this as a candidate for linux-2.6.11 release branch.  :)

Except the patch is malformed, and even after light editing, does not
apply to the 2.6.11 kernel :(

thanks,

greg k-h
