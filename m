Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVAGXyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVAGXyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVAGXyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:54:00 -0500
Received: from mail.tyan.com ([66.122.195.4]:25875 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261799AbVAGXxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:53:15 -0500
Message-ID: <3174569B9743D511922F00A0C943142307291355@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Fri, 7 Jan 2005 16:04:42 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86_64/kernel/setup.c

static void __init detect_ht(struct cpuinfo_x86 *c)

                phys_proc_id[cpu] = phys_pkg_id(index_msb);

--->
			  Phy_proc_id[cpu] = cpu_to_node[cpu];
Or
   	      // that is initial apicid
          phys_proc_id[cpu] = c->x86_apicid >> hweight32(c->x86_num_cores -
1);

YH

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Friday, January 07, 2005 2:18 PM
To: YhLu
Cc: Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
jamesclv@us.ibm.com; suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

On Fri, Jan 07, 2005 at 01:44:19PM -0800, YhLu wrote:
> Can you consider to use c->x86_apicid to get phy_proc_id, that is initial
> apicid.?

Where? 

-Andi
