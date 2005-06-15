Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVFOVhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVFOVhA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVFOVfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:35:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24780 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261584AbVFOVeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:34:01 -0400
Subject: Re: [RFC] Linux memory error handling
From: Dave Hansen <haveblue@us.ibm.com>
To: Russ Anderson <rja@sgi.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200506152127.j5FLRvvl1466135@clink.americas.sgi.com>
References: <200506152127.j5FLRvvl1466135@clink.americas.sgi.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 14:33:54 -0700
Message-Id: <1118871234.6620.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 16:27 -0500, Russ Anderson wrote:
> How about /sys/devices/system/memory/dimmX with links in
> /sys/devices/system/node/nodeX/ ?  Does that sound better?

Much better than /proc :)

However, we're already using /sys/devices/system/memory/ for memory
hotplug to represent Linux's view of memory, and which physical
addresses it is currently using.  I've thought about this before, and I
think that we may want to have /sys/.../memory/hardware for the DIMM
information and memory/logical for the memory hotplug controls.

One other minor thing.  You might want to think about referring to the
pieces of memory as things other than DIMMs.  On ppc64, for instance,
the hypervisor hands off memory in sections called LMBs (logical memory
blocks), and they're not directly related to any hardware DIMM.  The
same things will show up in other virtualized environments.

-- Dave

