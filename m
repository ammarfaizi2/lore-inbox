Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWCAXw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWCAXw1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWCAXw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:52:27 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:42306 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750714AbWCAXw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:52:26 -0500
Date: Wed, 1 Mar 2006 15:52:08 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] ocfs2 updates
Message-ID: <20060301235208.GA31587@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060301231034.GZ20175@ca-server1.us.oracle.com> <20060301153714.56d20f24.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301153714.56d20f24.akpm@osdl.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 03:37:14PM -0800, Andrew Morton wrote:
> Mark Fasheh <mark.fasheh@oracle.com> wrote:
> >
> > +					    "Extent %d at e_blkno %"MLFu64" of inode %"MLFu64" goes past ip_clusters of %u\n",
> 
> Sometime, please consider killing MLFu64 and friends.
Yeah, it's on my 'todo' list - enough people have asked now that it's clear
folks don't want it. The original idea behind it all was to avoid all the
casts involved. Anyway, I definitely intend to get to it.

> You covered most cases there, but sh64 implements u64 as `unsigned long
> long' (for example).
> 
> Generally we solve this problem by just using %ll and casting the args
> appropriately.   That does have some runtime cost on 32-bit.
>
> u64 and s64 are the easy case - it gets stickier on things like sector_t
> whose size is controlled by a CONFIG_thing on 32-bit.
Ah, cool. Thanks for pointing those out - it'll help as I try to remove this
stuff.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
