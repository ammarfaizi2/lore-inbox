Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVIKQhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVIKQhu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVIKQht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:37:49 -0400
Received: from fsmlabs.com ([168.103.115.128]:20918 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S964857AbVIKQht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:37:49 -0400
Date: Sun, 11 Sep 2005 09:44:16 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/14] x86_64: Use common functions in cluster and physflat
 mode
In-Reply-To: <20050909134503.A29351@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0509091439110.978@montezuma.fsmlabs.com>
References: <200509032135.j83LZ8gX020554@shell0.pdx.osdl.net>
 <20050905231628.GA16476@muc.de> <20050906161215.B19592@unix-os.sc.intel.com>
 <Pine.LNX.4.61.0509091003490.978@montezuma.fsmlabs.com>
 <20050909134503.A29351@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Ashok Raj wrote:

> In general we need
> 
> flat_mode - #cpus <= 8 (Hotplug defined or not, so we use mask version 
>                        for safety)
> 
> physflat or cluster_mode when #cpus >8.

I agree there.

> If we choose physflat as default for #cpus <=8 (with hotplug) would make
> IPI performance worse, since it would do one cpu at a time, and requires 2 
> writes per cpu for each IPI v.s just 2 for a flat mode mask version of the API.

I don't see the benefit then :/ I certainly hope we don't go that route.

Thanks,
	Zwane

