Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWE2COS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWE2COS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 22:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWE2COR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 22:14:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:31121 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751090AbWE2COR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 22:14:17 -0400
X-IronPort-AV: i="4.05,182,1146466800"; 
   d="scan'208"; a="42644146:sNHT28216755"
Subject: Re: [RFC]disable msi mode in pci_disable_device
From: Shaohua Li <shaohua.li@intel.com>
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Brice Goglin <brice@myri.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, tom.l.nguyen@intel.com
In-Reply-To: <20060526161043.A16912@unix-os.sc.intel.com>
References: <1148612307.32046.132.camel@sli10-desk.sh.intel.com>
	 <20060526125440.0897aef5.akpm@osdl.org> <44776491.1080506@myri.com>
	 <20060526161043.A16912@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Mon, 29 May 2006 10:12:32 +0800
Message-Id: <1148868752.32046.153.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 16:10 -0700, Rajesh Shah wrote:
> On Fri, May 26, 2006 at 10:26:57PM +0200, Brice Goglin wrote:
> > 
> > I just tried, the patch fixes our problem (no need to restore right
> > after saving to reenable MSI).
> > 
> Yeah, I agree this latest patch from Shaohua is the right thing,
> and that pci save/restore msi state functions should not have
> the side effect of disabling/enabling MSI. Shaohua, do drivers
> already call pci_disable_device() or will you have to patch
> them all to get the disable effect?
I guess most drivers already do this. It's recommended way (call
pci_disable_device in suspend) for a long time for suspend/resume. If
they really care, the driver authors should fix them.

Thanks,
Shaohua
