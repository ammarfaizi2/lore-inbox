Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271360AbUJVPMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271360AbUJVPMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271352AbUJVPKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:10:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:53193 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271342AbUJVPJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:09:10 -0400
Date: Fri, 22 Oct 2004 08:09:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make drivers/char/mem.c use remap_pfn_range()
In-Reply-To: <20041022143714.GT17038@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0410220807430.2101@ppc970.osdl.org>
References: <200410220206.i9M26gUi016689@hera.kernel.org>
 <20041022021908.GI17038@holomorphy.com> <Pine.LNX.4.58.0410220720220.2101@ppc970.osdl.org>
 <20041022143714.GT17038@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Oct 2004, William Lee Irwin III wrote:
> 
> What I posted shifted the correct argument, though vma->vm_pgoff would
> have been been better, as it shifted offset right by PAGE_SHIFT, where
> offset could have overflowed. I have no idea what you're referring to
> about shifting the wrong argument.

Ok, that patch just got lost.

Quite as well, actually. The whole point of changing remap_page_range() to 
remap_pfn_range() is to give the full range of page frame numbers, and 
just shifting "offset" back down thus seems to be a bug to me. Otherwise 
we migth as well just have continued with the old code.

			Linus
