Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWIIF0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWIIF0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 01:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWIIF0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 01:26:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:65504 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932154AbWIIF0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 01:26:03 -0400
Date: Fri, 8 Sep 2006 22:25:47 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, npiggin@suse.de,
       mingo@elte.hu
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
In-Reply-To: <20060908170352.C9446@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0609082222330.25269@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
 <20060908103529.A9121@unix-os.sc.intel.com>
 <Pine.LNX.4.64.0609081135590.23089@schroedinger.engr.sgi.com>
 <20060908130028.A9446@unix-os.sc.intel.com>
 <Pine.LNX.4.64.0609081316580.24016@schroedinger.engr.sgi.com>
 <20060908170352.C9446@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006, Siddha, Suresh B wrote:

> > One cacheline sized 128bytes will support all 1024 cpus that IA64 allows. 
> > cacheline align the cpumask?
> 
> one or more, it is unnecessary for the common case.

The common case is an arch with much less cpus. The maxinum on i386
f.e. is 255 meaning 8 bytes. That fits in the cacheline that is already
used for the stack frame of the calling function. 

