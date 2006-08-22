Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWHVFGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWHVFGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 01:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWHVFGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 01:06:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1927 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750727AbWHVFGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 01:06:31 -0400
Date: Mon, 21 Aug 2006 22:06:25 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: anton@samba.org, simon.derr@bull.net, nathanl@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060821220625.36abd1d9.pj@sgi.com>
In-Reply-To: <20060821215120.244f1f6f.akpm@osdl.org>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> If the kernel provider (ie: distro) has enabled cpusets then it would be
> appropriate that they also provide a hotplug script which detects whether their
> user is actually using cpusets and if not, to take some sensible default action

Interesting point - whether the default action to fix up the
cpuset configuration when a CPU goes on or offline should be:
 1) coded in kernel/cpuset.c, or
 2) coded in a hotplug script.

I've got 25 cents that says Andrew votes for (2).

At least so far as the cpuset aware portion of the coding goes,
it would probably be easier for me to code in a hotplug script.

I should learn enough about how hotplug scripts work to see if
this will really work.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
