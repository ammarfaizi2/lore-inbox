Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWBPDs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWBPDs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWBPDs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:48:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:20101 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932160AbWBPDs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:48:27 -0500
From: Neil Brown <neilb@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Thu, 16 Feb 2006 14:48:20 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17395.62980.490128.577826@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Possibly bug in radix_tree_delete, and fix.
In-Reply-To: message from Nick Piggin on Thursday February 16
References: <17395.58244.839605.685011@cse.unsw.edu.au>
	<43F3EE8F.8060000@yahoo.com.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 16, nickpiggin@yahoo.com.au wrote:
> 
> It should be basically an identical block to the one below in the main
> loop, yeah? You're missing the nr_cleared_tags bit.
> 
> Something like:
> 
>     tags[tag] = 1;
>     if (tag_get(pathp->node, tag, pathp->offset)) {
>        tag_clear(pathp->node, tag, pathp->offset);
>        if (!any_tag_set(pathp->node, tag)) {
>           tags[tag] = 0;
>           nr_cleared_tags++;
>        }
>     }
> 
> And you can add an
> Acked-by: Nick Piggin <npiggin@suse.de>

Yes, that's clearly better.  I've sent the revised patch out.

Thanks,
NeilBrown
