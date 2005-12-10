Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVLJIS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVLJIS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVLJIS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:18:58 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:55512 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964962AbVLJIS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:18:58 -0500
Date: Sat, 10 Dec 2005 00:18:43 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 00/10] Cpuset: rebind vma's and other refinements
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following ten patches provide automatic rebinding of per-vma
mempolicies after a cpuset is migrated, along with a variety
of other cpuset tweaks, fixes, cleanup and optimizations.

  1. remove marker_pid documentation
  2. minor spacing initializer fixes
  3. update_nodemask code reformat
  4. fork hook fix
  5. combine refresh_mems and update_mems
  6. implement cpuset_mems_allowed
  7. numa_policy_rebind cleanup
  8. number_of_cpusets optimization
  9. rebind vma mempolicies fix
 10. migrate all tasks in cpuset at once

Andrew - this is exactly the same set of 10 patches that
I sent to you one day ago, but forgot to cc lkml.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
