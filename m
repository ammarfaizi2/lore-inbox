Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWJ0NZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWJ0NZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 09:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbWJ0NZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 09:25:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8113 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750867AbWJ0NZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 09:25:01 -0400
Date: Fri, 27 Oct 2006 06:24:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
       paulus@samba.org, ak@suse.de, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] Create compat_sys_migrate_pages
In-Reply-To: <20061027102834.5db261af.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0610270622480.7342@schroedinger.engr.sgi.com>
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
 <20061026133305.b0db54e6.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
 <20061027102834.5db261af.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006, Stephen Rothwell wrote:

> No they aren't because they have compat routines that convert the bitmaps
> before calling the "normal" syscall.  They, importantly, only use
> compat_alloc_user_space once each.

Ah...

> > Fixing get_nodes() to do the proper thing would fix all of these
> > without having to touch sys_migrate_pages or creating a compat_ function
> > (which usually is placed in kernel/compat.c)
> 
> You need the compat_ version of the syscalls to know if you were called
> from a 32bit application in order to know if you may need to fixup the
> bitmaps that are passed from/to user mode.

The compat functions should be placed in kernel/compat.c next to 
compat_sys_move_pages.

