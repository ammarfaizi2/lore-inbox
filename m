Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWEHFqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWEHFqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWEHFqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:46:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:43637 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932314AbWEHFqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:46:50 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948407:sNHT24173688"
Subject: [PATCH 0/10] bulk cpu removal support
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:37 +0800
Message-Id: <1147067137.2760.77.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPU hotremove will migrate tasks and redirect interrupts off dead cpu.
To remove multiple CPUs, we should iteratively do single cpu removal.
If tasks and interrupts are migrated to a cpu which will be soon
removed, then we will trash tasks and interrupts again. The following
patches allow remove several cpus one time. It's fast and avoids
unnecessary repeated trash tasks and interrupts. This will help NUMA
style hardware removal and SMP suspend/resume. Comments and suggestions
are appreciated.

Thanks,
Shaohua
