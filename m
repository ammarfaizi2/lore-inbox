Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVG1Bts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVG1Bts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVG1Bts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:49:48 -0400
Received: from serv01.siteground.net ([70.85.91.68]:54679 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261220AbVG1Btr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:49:47 -0400
Date: Wed, 27 Jul 2005 18:50:00 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: akpm@zip.com.au, ak@suse.de, linux-kernel@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [patch] x86_64: fix cpu_to_node setup for sparse apic_ids
Message-ID: <20050728015000.GC23923@localhost.localdomain>
References: <20050728011540.GA23923@localhost.localdomain> <20050727182445.52be6000.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727182445.52be6000.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 06:24:45PM -0700, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > While booting with SMT disabled in bios, when using acpi srat to setup
> > cpu_to_node[],  sparse apic_ids create problems.  Here's a fix for that.
> > 
> 
> Again, I don't have enough info here to judge the urgency of this patch.
> 
> What are the consequences and risks of not having this patch in 2.6.13, and
> to how many machines?
> 

Without this patch, intel x86_64 boxes with hyperthreading disabled in the
bios (and which rely on srat for numa setup) endup having incorrect 
values in cpu_to_node[] arrays, causing sched domains to be built 
incorrectly etc.

Thanks,
Kiran
