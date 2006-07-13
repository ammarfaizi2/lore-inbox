Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWGMCKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWGMCKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 22:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWGMCKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 22:10:55 -0400
Received: from mga05.intel.com ([192.55.52.89]:6428 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750899AbWGMCKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 22:10:54 -0400
X-IronPort-AV: i="4.06,236,1149490800"; 
   d="scan'208"; a="97178538:sNHT27021197"
Subject: Re: [PATCH 4/5] PCI-Express AER implemetation: AER core and
	aerdriver
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <1152710184.3217.41.camel@laptopd505.fenrus.org>
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com>
	 <1152688565.28493.218.camel@ymzhang-perf.sh.intel.com>
	 <1152688926.28493.223.camel@ymzhang-perf.sh.intel.com>
	 <1152689546.28493.232.camel@ymzhang-perf.sh.intel.com>
	 <1152691570.28493.250.camel@ymzhang-perf.sh.intel.com>
	 <1152710184.3217.41.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Message-Id: <1152756520.28493.273.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 13 Jul 2006 10:08:40 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 21:16, Arjan van de Ven wrote:
> > + 
> > +	struct semaphore rpc_sema;	/* 
> > +					 * Semaphore access required to
> > +					 * access, add, remove, or print AER
> > +				 	 * aware devices in this RPC hierarchy
> > +					 */
> 
> 
> Hi, 
> 
> sorry to bug you again..
Any comment is welcome.

>  but is there a reason you're introducing a new
> semaphore and not a mutex? From looking at the code it could/should be a
> mutex...
It could be a mutex and be deleted because every root port has its own rpc. workqueue
could guarantee only one keventd will service the work at the same time.
