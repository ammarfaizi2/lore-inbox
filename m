Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVHSDGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVHSDGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVHSDGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:06:21 -0400
Received: from ns.suse.de ([195.135.220.2]:38850 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750970AbVHSDGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:06:21 -0400
Date: Fri, 19 Aug 2005 05:06:16 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 !NUMA node_to_cpumask broken in early boot
Message-ID: <20050819030615.GH22993@wotan.suse.de>
References: <Pine.LNX.4.61.0508181919230.28588@montezuma.fsmlabs.com> <20050819021216.GF22993@wotan.suse.de> <Pine.LNX.4.61.0508182043310.28588@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508182043310.28588@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the feedback, ugly indeed, i was really trying to avoid adding 
> a new API function or extra cpu_* variables. Ok, here is an 
> early_node_to_cpumask instead.

Thinking about it again it's most likely broken with CPU hotplug anyways
whatever you're doing. So how does your code handle adding new 
CPUs?  If it does can the normal CPU bootup be handled in the 
same way. Then this wouldn't be needed at all.

-Andi
