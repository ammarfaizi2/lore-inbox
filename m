Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbVDATLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbVDATLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 14:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVDATLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 14:11:24 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:14881 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S262853AbVDATLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 14:11:20 -0500
Date: Fri, 1 Apr 2005 13:09:42 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question about do_IRQ + 4k stacks
Message-ID: <20050401190942.GC2104@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20050330221042.GZ2104@hygelac> <424B5CFE.6010907@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B5CFE.6010907@didntduck.org>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 01 Apr 2005 19:11:18.0843 (UTC) FILETIME=[9582F0B0:01C536EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 09:14:22PM -0500, bgerst@didntduck.org wrote:
> It checks for both process context (system call or kernel thread) or 
> interrupt context (nested irqs) stack overflows.

ok, thanks. 

so we really only have 3k stacks rather than 4k stacks, right? if any
code exceeds 3k stacks and is preempted by an interrupt, we can
trigger this check and hang the system as a result (I notice that at
least RHEL 4's kernels enable this check by default, not sure about
other kernels).

Thanks,
Terence


