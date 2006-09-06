Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWIFUCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWIFUCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWIFUCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:02:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:27030 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751360AbWIFUCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:02:05 -0400
Date: Wed, 6 Sep 2006 15:01:55 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Yanmin Zhang <yanmin.zhang@intel.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: pci error recovery procedure
Message-ID: <20060906200155.GL7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com> <20060831175001.GE8704@austin.ibm.com> <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com> <20060901212548.GS8704@austin.ibm.com> <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com> <1157360592.22705.46.camel@localhost.localdomain> <1157423528.20092.365.camel@ymzhang-perf.sh.intel.com> <20060905190115.GE7139@austin.ibm.com> <1157506016.20092.386.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157506016.20092.386.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 09:26:56AM +0800, Zhang, Yanmin wrote:
> > > The
> > > error_detected of the drivers in the latest kernel who support err handlers
> > > always returns PCI_ERS_RESULT_NEED_RESET. They are typical examples.
> > 
> > Just because the current drivers do it this way does not mean that this is
> > the best way to do things.
>
> If it's not the best way, why did you choose to reset slot for e1000/e100/ipr
> error handlers? They are typical widely-used devices. To make it easier to
> add error handlers?

I did it that way just to get going, get something working. I do not
have hardware specs for any of these devices, and do not have much of 
an idea of what they are capable of; the recovery code I wrote is of
"brute force, hit it with a hammer"-nature.  Driver writers who 
know thier hardware well, and are interested in a more refined 
approach are encouraged to actualy use a more refined approach.

--linas

