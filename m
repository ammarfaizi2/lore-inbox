Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVHSCMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVHSCMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 22:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVHSCMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 22:12:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16318 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750936AbVHSCMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 22:12:18 -0400
Date: Fri, 19 Aug 2005 04:12:16 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 !NUMA node_to_cpumask broken in early boot
Message-ID: <20050819021216.GF22993@wotan.suse.de>
References: <Pine.LNX.4.61.0508181919230.28588@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508181919230.28588@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 08:07:53PM -0600, Zwane Mwaikambo wrote:
> node_to_cpumask on non NUMA systems is broken if used before all the 
> processors have been brought up as it returns cpu_online_map, as opposed 
> to NUMA i386 systems which does it earlier than AP bringup. So return 
> which processors responded via cpu_present_map and switch to 
> cpu_online_map during normal runtime. This was found whilst testing a 
> patch which does node dependent work before APs have all gone online.

Very ugly and will probably cause code bloat.

If anything define a special early_node_to ... function for this.

-Andi
