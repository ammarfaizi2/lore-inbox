Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbVLNDvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVLNDvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbVLNDvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:51:13 -0500
Received: from cantor2.suse.de ([195.135.220.15]:37055 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932603AbVLNDvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:51:12 -0500
Date: Wed, 14 Dec 2005 04:51:11 +0100
From: Andi Kleen <ak@suse.de>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [discuss] [PATCH] Export cpu topology for IA32 and x86_64 by sysfs
Message-ID: <20051214035111.GF15804@wotan.suse.de>
References: <8126E4F969BA254AB43EA03C59F44E840431BB03@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E840431BB03@pdsmsx404>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:11:00AM +0800, Zhang, Yanmin wrote:
> The patch exports the cpu topology info through sysfs on ia32/x86_64
> machines. The info is similar to /proc/cpuinfo.
> 
> The exported items are:
> /sys/devices/system/cpu/cpuX/topology/physical_package_id(representing
> the physical package id of  cpu X)
> /sys/devices/system/cpu/cpuX/topology/core_id (representing the cpu core
> id  to cpu X)
> /sys/devices/system/cpu/cpuX/topology/thread_siblings (representing the
> thread siblings to cpu X)
> /sys/devices/system/cpu/cpuX/topology/core_siblings (represeting the
> core siblings to cpu X)

Hmm, I'm not sure it is that useful. Did someone decide to move
all information from cpuinfo into sysfs? 

And if it's done I think it needs Documentation somewhere.

Anyways, the notifier is wrong. You need to handle CPU_UP_CANCELLED
too.

And you could probably shrink the code size of the show function
in half by switching data instead of functions.


-Andi

