Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWCIGw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWCIGw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWCIGw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:52:26 -0500
Received: from ns.suse.de ([195.135.220.2]:54448 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750948AbWCIGwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:52:25 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:51:22 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 14] knfsd: Introduction
Message-ID: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches changes the code for lookup up
authentication/authorisation caches in sunrpc as used by nfsd.  That
than having a delightful macro that defines a function of a particular
type of cache, the functions are coded on a more traditional manner
using library routines.

This will hopefully make the code more maintainable.

This series should not effect the functionality at all -- except maybe
to fix some very minor bugs

This is against 2.6.16-rc5-mm2 and is NOT suitable for 2.6.16, but maybe for .17
(though holding it back to .18 wouldn't be a big problem if any issues came up).

Thanks,
NeilBrown


 [PATCH 000 of 14] knfsd: Introduction
 [PATCH 001 of 14] knfsd: Change the store of auth_domains to not be a 'cache'.
 [PATCH 002 of 14] knfsd: Break the hard linkage from svc_expkey to svc_export
 [PATCH 003 of 14] knfsd: Get rid of 'inplace' sunrpc caches
 [PATCH 004 of 14] knfsd: Create cache_lookup function instead of using a macro to declare one.
 [PATCH 005 of 14] knfsd: Convert ip_map cache to use the new lookup routine.
 [PATCH 006 of 14] knfsd: Use new cache_lookup for svc_export
 [PATCH 007 of 14] knfsd: Use new cache_lookup for svc_expkey cache.
 [PATCH 008 of 14] knfsd: Use new sunrpc cache for rsi cache
 [PATCH 009 of 14] knfsd: Use new cache code for rsc cache
 [PATCH 010 of 14] knfsd: Use new cache code for name/id lookup caches
 [PATCH 011 of 14] knfsd: An assortment of little fixes to the sunrpc cache code.
 [PATCH 012 of 14] knfsd: Remove DefineCacheLookup
 [PATCH 013 of 14] knfsd: Unexport cache_fresh and fix a small race.
 [PATCH 014 of 14] knfsd: Convert sunrpc_cache to use krefs
