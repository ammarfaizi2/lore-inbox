Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVKGGLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVKGGLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVKGGLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:11:12 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:18620 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964791AbVKGGLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:11:11 -0500
Date: Sun, 6 Nov 2005 22:10:55 -0800
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] cpuset: rebind numa vma mempolicy
Message-Id: <20051106221055.2c8760d8.pj@sgi.com>
In-Reply-To: <20051104053120.549.73652.sendpatchset@jackhammer.engr.sgi.com>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
	<20051104053120.549.73652.sendpatchset@jackhammer.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew - please remove these two patches from *-mm for now.  I need to
think more about the mmap_sem locking issues.  The questions you asked
were good ones - thanks.  My answers so far suck.

	[PATCH 2/5] cpuset: rebind numa vma mempolicy
	[PATCH 6/5] cpuset: rebind numa vma mempolicy fix
aka
	cpuset-rebind-numa-vma-mempolicy.patch
	cpuset-rebind-numa-vma-mempolicy-fix.patch

So far as I can tell, nothing is actually broken with this pair of
patches.  My cpuset function and stress tests still passed.  But they
are too hacky^W non-deterministic.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
