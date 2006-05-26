Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWEZXNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWEZXNL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWEZXNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:13:11 -0400
Received: from mga05.intel.com ([192.55.52.89]:25434 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750989AbWEZXNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:13:10 -0400
X-IronPort-AV: i="4.05,178,1146466800"; 
   d="scan'208"; a="43156010:sNHT27913375"
Date: Fri, 26 May 2006 16:10:44 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Brice Goglin <brice@myri.com>
Cc: Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, tom.l.nguyen@intel.com, rajesh.shah@intel.com
Subject: Re: [RFC]disable msi mode in pci_disable_device
Message-ID: <20060526161043.A16912@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <1148612307.32046.132.camel@sli10-desk.sh.intel.com> <20060526125440.0897aef5.akpm@osdl.org> <44776491.1080506@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <44776491.1080506@myri.com>; from brice@myri.com on Fri, May 26, 2006 at 10:26:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:26:57PM +0200, Brice Goglin wrote:
> 
> I just tried, the patch fixes our problem (no need to restore right
> after saving to reenable MSI).
> 
Yeah, I agree this latest patch from Shaohua is the right thing,
and that pci save/restore msi state functions should not have
the side effect of disabling/enabling MSI. Shaohua, do drivers
already call pci_disable_device() or will you have to patch
them all to get the disable effect?

Rajesh
