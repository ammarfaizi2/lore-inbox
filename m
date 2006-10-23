Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWJWDhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWJWDhx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWJWDhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:37:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:7356 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1751388AbWJWDhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:37:52 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,341,1157353200"; 
   d="scan'208"; a="149039867:sNHT19288871"
Subject: Re: 2.6.19-rc2 ipw2200 breakage with wpa_supplicant
From: Zhu Yi <yi.zhu@intel.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jketreno@linux.intel.com
In-Reply-To: <45399521.30502@shaw.ca>
References: <45399093.6090306@shaw.ca>  <45399521.30502@shaw.ca>
Content-Type: text/plain
Organization: Intel Corp.
Date: Mon, 23 Oct 2006 11:35:17 +0800
Message-Id: <1161574517.19188.32.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 21:33 -0600, Robert Hancock wrote:
> Robert Hancock wrote:
> > Something changed between 2.6.18-mm1 and 2.6.19-rc2 to cause my laptop's 
> > ipw2200 to be unable to associate with the access point using 
> > NetworkManager and wpa_supplicant. I keep seeing this kind of thing over 
> > and over in the wpa_supplicant output:
> 
> It looks like the bad patch is this one. Reverting it makes it work 
> again. Either there's a bug in here or it's a change breaking working 
> userspace, either way, no good:
> 
> [PATCH] WE-21 for ipw2200
> 
> author	Jean Tourrilhes <jt@hpl.hp.com>
> 	Wed, 30 Aug 2006 01:01:40 +0000 (18:01 -0700)
> committer	John W. Linville <linville@tuxdriver.com>
> 	Mon, 25 Sep 2006 20:52:16 +0000 (16:52 -0400)
> commit	919ee6ddcd3fcff09dee90c11af17a802196ad1f
> tree	c45e35201d7a3f2c998fc316898f902fd85fdfd2
> parent	b978d0278c3a4c41bda806743c6ef5dca86b4c61
> 
> [PATCH] WE-21 for ipw2200
> 
> Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

This is a wpa_supplicant WE-21 incompatibility problem. Using iwconfig
directly works. Don't know if upgrading wpa_supplicant helps.

Thanks,
-yi
