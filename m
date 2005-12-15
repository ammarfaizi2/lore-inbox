Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbVLODhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbVLODhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbVLODhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:37:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:6864 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161007AbVLODhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:37:14 -0500
Date: Thu, 15 Dec 2005 04:37:09 +0100
From: Andi Kleen <ak@suse.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Nathan Lynch <ntl@pobox.com>
Subject: Re: [discuss] [PATCH] Export cpu topology for IA32 and x86_64 by sysfs
Message-ID: <20051215033709.GS23384@wotan.suse.de>
References: <88056F38E9E48644A0F562A38C64FB6006A22399@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6006A22399@scsmsx403.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not really. The current display in /proc/cpuinfo, though useful for
> human reader,
> is not very friendly to scripts. And if one wants to find out which
> logical CPUs belong
> to the same core, there will have to be some amount of code in userlevel
> to parse
> the /proc/cpuinfo and get this info. So, we thought that it may be
> useful to 
> export the masks to the user directly in a genric way. And, while doing
> that
> thinking was adding new fields in /sysfs rather than /proc/ was better.

Hmm - having written both /proc and /sys parsers i'm not sure your new
setup will be any easier to handle in a program than /proc/cpuinfo. Probably not.

I would suggest you supply a standard C library and command line utility
at least - but at least for the later the output would
be likely not that different from cat /proc/cpuinfo

> Having said that, I feel Nathan's suggestion of doing it in more
> architecturally-neutral way should be better than this. We will have a
> relook at this one now.

That makes sense. /proc/cpuinfo is not that bad in itself, except that
it's very architecture dependent.

-Andi

