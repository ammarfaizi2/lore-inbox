Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWC1WY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWC1WY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWC1WY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:24:56 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:22663 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932461AbWC1WYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:24:55 -0500
Date: Tue, 28 Mar 2006 17:24:17 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org, torvalds@osdl.org, ebiederm@xmission.com,
       gregkh@suse.de, bcrl@kvack.org, dave.jiang@gmail.com,
       arjan@infradead.org, maneesh@in.ibm.com, muralim@in.ibm.com
Subject: Re: [RFC][PATCH 0/10] 64 bit resources
Message-ID: <20060328222417.GC20335@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060324011217.7b8aade1.akpm@osdl.org> <20060324180538.GC4406@in.ibm.com> <DA5FFD16-3FBF-4CB1-BD38-0125E503512F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA5FFD16-3FBF-4CB1-BD38-0125E503512F@kernel.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 10:34:39AM -0600, Kumar Gala wrote:
[..]
> 
> >Here are more compilation results with allnoconfig, allmodconfig and
> >allyesconfig on i386. I have picked section sizes from the output  
> >of readelf.
> >
> >allnoconfig
> >----------
> >
> >vmlinux bloat: 0
> >
> >.text bloat: 1008 bytes
> >.data bloat: 672 bytes.
> >.init.text bloat: 128 bytes
> >.init.data bloat: 0 bytes
> >
> >(Not sure why vmlinux size difference is zero, given the fact that few
> > sections are showing bloated size)
> >
> >
> >allmodconfig (CONFIG_DEBUG_INFO=n)
> >------------
> >
> >vmlinux bloat:4096 bytes
> >
> >.text bloat: 4064 bytes
> >.init.text bloat: 470 bytes
> >.data bloat: 640 bytes
> >
> >
> >allyesconfig  (CONFIG_DEBUG_INFO=n)
> >-----------
> >
> >vmlinux size bloat: 52K
> >
> >.text bloat: 28.5K
> >.init_text bloat: 5K
> >.eh_frame bloat: 16K  (What's that. Looks big)
> >.rodata bloat: 152 bytes
> >.data bloat: 768 bytes
> 
> So the bloat seems be in the drivers as expected.
> 
> Vivek, mind updating these against -mm2 also, can you fixup arch/ 
> powerpc/kernel/pci_32.c.
> 
> Andrew, any issues in merging into -mm?

These patches are now in -mm2. I did some cross compilation for powerpc
and fixed more warnings including powerpc/kernel/pci_32.c. Posting patches
in a separate thread.

-vivek

