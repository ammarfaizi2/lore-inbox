Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264688AbUD1F7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264688AbUD1F7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 01:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264690AbUD1F7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 01:59:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:64273 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264688AbUD1F7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 01:59:34 -0400
Date: Tue, 27 Apr 2004 22:57:41 -0700
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, ashok.raj@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: ia64-cpu-hotplug-cpu_present.patch?
Message-Id: <20040427225741.2fe78d88.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Ashok,

How did the following patch, named ia64-cpu-hotplug-cpu_present.patch,
dated 25 April 2004, end up in Andrew's patch set?

I cannot find any mention of it on lkml or any other email list that
either Google or I track.

Is there some backdoor path to Andrew's patch directory I don't know of ;)?

The patch comment was:

    This patch adds cpu_present_map, cpu_present() and for_each_cpu_present() to
    distinguish between possible cpu's in a system and cpu's physically present in
    a system.  Before cpu hotplug was introduced cpu_possible() represented cpu's
    physically present in the system.  With hotplug capable Kernel, there is a
    requirement to distinguish a cpu as possible verses a CPU physically present
    in the system.  This is required so thta when smp_init() attempts to start all
    cpu's it should now only attempt to start cpu's present in the system.  When a
    hotplug cpu is physically inserted cpu_present_map will have bits updated
    dynamically.

This patch is cutting across the bitmap+cpumask rework that I'm working on.
I'm going to try to refit it to my new code, but may well break something.

I'll try to remember to include Ashok explicitly on the next version of my
patch set, so that he can review my changes, and catch what I break.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
