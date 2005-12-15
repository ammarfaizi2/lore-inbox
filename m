Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbVLOCDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVLOCDP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVLOCDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:03:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64700 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030365AbVLOCDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:03:12 -0500
Date: Wed, 14 Dec 2005 18:03:10 -0800
From: Paul Jackson <pj@sgi.com>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH 1/2] Export cpu info by sysfs
Message-Id: <20051214180310.b5b9c15f.pj@sgi.com>
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E840431C3E2@pdsmsx404>
References: <8126E4F969BA254AB43EA03C59F44E840431C3E2@pdsmsx404>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yanmin wrote:
> cpumask_scnprintf(buf, NR_CPUS+1, cpu_core_map[cpu]);

Paul wrote:
> The 2nd arg, "NR_CPUS+1", is wrong.  It should be the length
> of the buffer

Yanmin replied:
> In theory, it's a problem which doesn't exist in fact.

Aha - you are right.  My confusion was that I had forgotten
the format used by cpumask_scnprintf, and thought it was one
of the other formats, not a hex mask, that could overflow
NR_CPUS+1 characters of output.  Please nevermind my confusion.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
