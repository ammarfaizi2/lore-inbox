Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVCUTQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVCUTQg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVCUTQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:16:35 -0500
Received: from fmr21.intel.com ([143.183.121.13]:15251 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261852AbVCUTO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:14:57 -0500
Date: Mon, 21 Mar 2005 11:14:49 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
Message-ID: <20050321111449.A5052@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com> <pan.2005.03.19.13.50.15.938352@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <pan.2005.03.19.13.50.15.938352@yahoo.com>; from i_p_a_u_l@yahoo.com on Sat, Mar 19, 2005 at 03:50:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 03:50:16PM +0200, Paul Ionescu wrote:
> 
> Does this mean that when it will be ported for i386, I will be able to
> really use my Docking Station ?

No. The current patches only trigger when a _root_ bridge is
hot-added, not a PCI to PCI bridge (which is what the docking 
station is). The code to support p2p bridge hotplug will benefit
from these patches but more code is needed to support that.

> Does it rescan the DSDT to find new additions to ACPI devices ?
> 
It scans the ACPI namespace under the root bridge that was added.
Any pci devices underneath are scanned and added, but there isn't
any code to look for non-PCI devices there.

Rajesh
