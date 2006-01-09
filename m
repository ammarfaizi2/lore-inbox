Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWAIUJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWAIUJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWAIUJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:09:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:30399 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751272AbWAIUJ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:09:26 -0500
Subject: RE: [patch 2/2] add x86-64 support for memory hot-add
From: keith <kmannth@us.ibm.com>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: Andi Kleen <ak@suse.de>, Matt Tolentino <metolent@cs.vt.edu>,
       akpm@osdl.org, discuss@x86-64.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C0B777A@fmsmsx406.amr.corp.intel.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C0B777A@fmsmsx406.amr.corp.intel.com>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 12:09:07 -0800
Message-Id: <1136837348.31043.105.camel@knk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 11:55 -0800, Tolentino, Matthew E wrote:
> Andi Kleen <mailto:ak@suse.de> wrote:
> > On Monday 09 January 2006 16:21, Matt Tolentino wrote:
> >> Add x86-64 specific memory hot-add functions, Kconfig options,
> >> and runtime kernel page table update functions to make
> >> hot-add usable on x86-64 machines.  Also, fixup the nefarious
> >> conditional locking and exports pointed out by Andi.
> > 
> > I'm trying to stabilize my tree for the 2.6.16 submission right now
> > and this one comes a bit too late and is a bit too involved
> > to slip through - sorry. I will consider it after Linus
> > has merged the whole batch of changes for 2.6.16 - so hopefully
> > in 2.6.17.
> > 
> >> +/*
> >> + * Memory hotplug specific functions
> >> + * These are only for non-NUMA machines right now.
> > 
> > How much work would it be to allow it for NUMA kernels too?

Not too much.  I have a start of this code.  Just saving off the SRAT
locality information and using it during the add-event to decide which
node it goes to. But I went to test this weekend on a multi-node system
and the underlying __add_pages refused to add the pages.  The underlying
sparsemem can do this (It works for PPC).  I am still collecting the
debug info needed.

When I get the numa system sorted I will post patches. 

-- 
keith <kmannth@us.ibm.com>

