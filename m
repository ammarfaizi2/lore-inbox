Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWCASjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWCASjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWCASjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:39:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17881 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750778AbWCASjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:39:04 -0500
Date: Wed, 1 Mar 2006 10:38:53 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
In-Reply-To: <200603011934.34136.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0603011037350.29248@schroedinger.engr.sgi.com>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
 <200602281813.47234.ak@suse.de> <20060301102757.f2eec70e.pj@sgi.com>
 <200603011934.34136.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2006, Andi Kleen wrote:

> > No need to implement a sysctl for this.  The current cpuset facility
> > should provide just what you want, if I am understanding correctly.
> 
> The main reason i'm reluctant to use this is that the cpuset fast path
> overhead (e.g. in memory allocators etc.) is quite large and I wouldn't like 
> to recommend people to enable all this overhead by default just to get 
> more useful dcache/inode behaviour on small NUMA systems.

Is this a gut feeling or do you have some measurements to back that up? 
Paul worked hard on making all the overhead in critical paths as light as 
possible and from what I can see he did a very good job.



