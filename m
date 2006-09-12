Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWILTjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWILTjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWILTjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:39:01 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:64993 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030380AbWILTjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:39:00 -0400
Date: Tue, 12 Sep 2006 14:38:57 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Yanmin Zhang <yanmin.zhang@intel.com>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: Re: pci error recovery procedure
Message-ID: <20060912193857.GB29167@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com> <20060831175001.GE8704@austin.ibm.com> <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com> <20060901212548.GS8704@austin.ibm.com> <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com> <20060905191739.GF7139@austin.ibm.com> <1157508270.20092.426.camel@ymzhang-perf.sh.intel.com> <20060906203939.GM7139@austin.ibm.com> <1157599136.20092.529.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157599136.20092.529.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 11:18:56AM +0800, Zhang, Yanmin wrote:
> The error recovery procedures
> are to process pci hardware errors instead of device driver bug.

Over the last three years, we've uncovered (and fixed) dozens of 
device driver bugs that were only detected because of the pci error
detection hardware.  The ability to get device dumps is important,
because many of these bugs are hard to reproduce, require getting
PCI bus analyzers attached to the system, etc.

> Current error handler infrastructure could support pci-e, but I want a better
> solution to faciliate driver developers to add error handlers more easily. My
> startpoint is driver developer. If they are not willing to add error handlers,
> it's impossible to do so for all drivers by you and me.

Right. As a result, we only care about the products that we actually 
sell to customers. PCI error recovery is not some "gee its nice" piece
of eye-candy or chrome: either one is serious about high-availability,
or one is not.

--linas



