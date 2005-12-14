Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbVLNEO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbVLNEO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 23:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbVLNEO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 23:14:28 -0500
Received: from thorn.pobox.com ([208.210.124.75]:41916 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1030314AbVLNEO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 23:14:27 -0500
Date: Tue, 13 Dec 2005 23:14:20 -0500
From: Nathan Lynch <ntl@pobox.com>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH 1/2] Export cpu info by sysfs
Message-ID: <20051214041419.GA3475@localhost.localdomain>
References: <8126E4F969BA254AB43EA03C59F44E840431BB3B@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E840431BB3B@pdsmsx404>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-

Zhang, Yanmin wrote:
> I worked out 2 patches to export cpu topology and cache info by sysfs.
> 
> The first patch is to export cpu topology info including below items
> (attributes) which are similar to /proc/cpuinfo.
> 
> /sys/devices/system/cpu/cpuX/topology/physical_package_id(representing
> the physical package id of  cpu X)
> /sys/devices/system/cpu/cpuX/topology/core_id (representing the cpu core
> id  to cpu X)
> /sys/devices/system/cpu/cpuX/topology/thread_id (representing the cpu
> thread id  to cpu X)
> /sys/devices/system/cpu/cpuX/topology/thread_siblings (representing the
> thread siblings to cpu X)
> /sys/devices/system/cpu/cpuX/topology/core_siblings (represeting the
> core siblings to cpu X)

I haven't looked at the patches in detail, but I have a concern about
this approach.  How is it that making new architecture-specific
attributes under cpu directories in sysfs is preferable to the already
architecture-specific format of /proc/cpuinfo and other proc entries?

If we're going to create a new user interface for exposing system
topology (cores and threads etc), I would like for it to be as
architecture-neutral as possible.  We already do this for numa, for
example.


Nathan
