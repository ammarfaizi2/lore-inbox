Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVCRVjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVCRVjU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 16:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVCRVjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 16:39:20 -0500
Received: from fmr24.intel.com ([143.183.121.16]:38802 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261387AbVCRVjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 16:39:17 -0500
Date: Fri, 18 Mar 2005 13:38:57 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: [RFC/Patch 0/12] ACPI based root bridge hot-add
Message-ID: <20050318133856.A878@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series of patches to support ACPI hot-add of a root
bridge hierarchy. The added hierarchy may contain other p2p 
bridges and end/leaf I/O devices too. The root bridge itself is
assumed to have been assigned resource ranges, but the p2p
bridges and end devices are not required to be initialized by
firmware. Most of the code changes are to make the existing code
flows suitable for such a hierarchy of bridges & devices.

This code supports hot-add on ia64 only for now.It does not yet
support I/O APIC hot-add, which is needed to make this fully
functional.  The patches are against 2.6.11-mm4 (plus the patch 
needed for ia64 to boot). I've tested to make sure this does not 
break end/leaf device hotplug on the hotplug capable ia64 box I have.

Thanks,
Rajesh
