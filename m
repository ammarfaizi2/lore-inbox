Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWBQPwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWBQPwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWBQPwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:52:15 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:16567 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751507AbWBQPwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:52:14 -0500
Subject: Re: [PATCH: 005/012] Memory hotplug for new nodes v.2.(pgdat alloc
	caller for x86-64)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
In-Reply-To: <20060217211729.4072.Y-GOTO@jp.fujitsu.com>
References: <20060217211729.4072.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 07:51:37 -0800
Message-Id: <1140191497.21383.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 22:29 +0900, Yasunori Goto wrote:
> +       zone_type = start_pfn < MAX_DMA32_PFN ?
> +                   ZONE_DMA32 : ZONE_NORMAL; 

Please change this to something which we can more easily parse, such as
this:

	if (start_pfn < MAX_DMA32_PFN)
		zone_type = ZONE_DMA32;
	else
		zone_type = ZONE_NORMAL;

I think it is worth the extra two lines.

-- Dave

