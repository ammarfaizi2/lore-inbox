Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbWGFBXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWGFBXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 21:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWGFBXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 21:23:25 -0400
Received: from mga06.intel.com ([134.134.136.21]:46999 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S965112AbWGFBXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 21:23:24 -0400
X-IronPort-AV: i="4.06,211,1149490800"; 
   d="scan'208"; a="61086673:sNHT34784827"
Subject: Re: [PATCH] ixgb: add PCI Error recovery callbacks
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Auke Kok <auke-jan.h.kok@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       netdev@vger.kernel.org, wenxiong@us.ibm.com
In-Reply-To: <20060705194437.GJ29526@austin.ibm.com>
References: <20060629162634.GC5472@austin.ibm.com>
	 <1151905766.28493.129.camel@ymzhang-perf.sh.intel.com>
	 <44ABDF87.8000801@intel.com>  <20060705194437.GJ29526@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1152148899.28493.168.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 06 Jul 2006 09:21:39 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 03:44, Linas Vepstas wrote:
> On Wed, Jul 05, 2006 at 08:49:27AM -0700, Auke Kok wrote:
> > Zhang, Yanmin wrote:
> > >On Fri, 2006-06-30 at 00:26, Linas Vepstas wrote:
> > >>Adds PCI Error recovery callbacks to the Intel 10-gigabit ethernet
> > >>ixgb device driver. Lightly tested, works.
> > >
> > >Both pci_disable_device and ixgb_down would access the device. It doesn't
> > >follow Documentation/pci-error-recovery.txt that error_detected shouldn't 
> > >do
> > >any access to the device.
> > 
> > Moreover, it was Linas who wrote this documentation in the first place :)
> 
> On the pSeries, its harmless to try to do i/o; the i/o will e blocked.
In the future, we might move the pci error recovery codes to generic to
support other platforms which might not block I/O. So it's better to follow
Documentation/pci-error-recovery.txt when adding error recovery codes into driver.
