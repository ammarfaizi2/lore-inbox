Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVI3O62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVI3O62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVI3O61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:58:27 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13724 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030308AbVI3O61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:58:27 -0400
Date: Fri, 30 Sep 2005 09:58:23 -0500
To: Doug Maxey <dwm@maxeymade.com>
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] ppc64: EEH Halt if bad drivers spin in error condition
Message-ID: <20050930145822.GM29826@austin.ibm.com>
References: <20050930010228.GG6173@austin.ibm.com> <200509300449.j8U4n94d014765@falcon30.maxeymade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509300449.j8U4n94d014765@falcon30.maxeymade.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 11:49:09PM -0500, Doug Maxey was heard to remark:
> 
> On Thu, 29 Sep 2005 20:02:28 CDT, linas wrote:
> >
> >07-eeh-spin-counter.patch
> >
> >One an EEH event is triggers, all further I/O to a device is blocked (until
> >reset).  Bad device drivers may end up spinning in their interrupt handlers, 
> >trying to read an interrupt status register that will never change state.
> >This patch moves that spin counter to a per-device structure, and adds
> >some diagnostic prints to help locate the bad driver.
> >
> 
> Which struct gets the element?

struct pci_dn, which Paulus recently introduced; it splits off the pci
parts from struct device_node.  Think of it as holding all the firmaware
and arch-specific peices that can't be jammed in the generic struct pci_dev.

--linas

