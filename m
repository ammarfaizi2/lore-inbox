Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVAHAeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVAHAeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVAHAeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:34:17 -0500
Received: from colin2.muc.de ([193.149.48.15]:29457 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261611AbVAHAeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:34:14 -0500
Date: 8 Jan 2005 01:34:12 +0100
Date: Sat, 8 Jan 2005 01:34:12 +0100
From: Andi Kleen <ak@muc.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: YhLu <YhLu@tyan.com>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050108003412.GA98595@muc.de>
References: <3174569B9743D511922F00A0C943142307291358@TYANWEB> <200501071626.57918.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071626.57918.jamesclv@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 04:26:57PM -0800, James Cleverdon wrote:
> Already done, although not dividing along AMD vs. Intel lines.  
> phys_pkg_id() indirects through the subarch table.  See 
> genapic_cluster.c and genapic_flat.c for details.
> 
> We may need a third subarch for AMD's Extended APIC mode boxes.

I'm not convinced we do. Things seem to work with BSP APIC-ID = 0.
Is there any real reason to not just require that?

> 
> Can you suggest some heuristics for detecting such a system and 
> discerning it from a clustered APIC box?  (Hopefully, without using MPS 
> or ACPI table ID string lookups.)

Early PCI scan would work in the worst case. All Opterons have a builtin
northbridge with a specific ID.  There is already other code that 
checks for these.

-Andi

