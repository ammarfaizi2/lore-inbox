Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752090AbWHODmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbWHODmd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 23:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWHODmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 23:42:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:63846 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752090AbWHODmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 23:42:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MIlCkG9pzSOVlfxAWoZzN7BM7JFQ47N3753c2mif1Ft/Ud+0b7QtYhIHY7f4ECbfyGqZk2Wb2TExuN5i64/Hr6ySbyustLoc9J77yy1PIF4tvzG2zPpN6IXLvM4tYwVKxXYz2s5xqOUb+Mkx0FgERqQruS6TARNqDMIIXBvFLPY=
Date: Tue, 15 Aug 2006 07:42:28 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Lei Jin <jinlei@cs.pitt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What kind of page allocation optimization does the kernel implemented?
Message-ID: <20060815034228.GB5163@martell.zuzino.mipt.ru>
References: <44E13A76.80508@cs.pitt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E13A76.80508@cs.pitt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 11:07:34PM -0400, Lei Jin wrote:
> Does the kernel support the page coloring algorithm? I cannot find any
> clue from the code.

IANVMHacker, but

$ grep color -n -r mm/
mm/page_alloc.c:1743:    * of pages of one half of the possible page
colors
mm/page_alloc.c:1744:    * and the other with pages of the other colors.
mm/mmap.c:379:  rb_insert_color(&vma->vm_rb, &mm->mm_rb);
mm/nommu.c:351: rb_insert_color(&vma->vm_rb, &nommu_vma_tree);
mm/slab.c:295:  unsigned int colour_next;       /* Per-node cache coloring */
mm/mempolicy.c:1420:    rb_insert_color(&new->nd, &sp->root);

