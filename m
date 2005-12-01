Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVLAFp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVLAFp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 00:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLAFp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 00:45:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1807 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932086AbVLAFpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 00:45:55 -0500
Date: Thu, 1 Dec 2005 06:45:41 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Adam Litke <agl@us.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Fix handling of ELF segments with zero filesize
Message-ID: <20051201054541.GA22097@alpha.home.local>
References: <20051201002049.GB14247@localhost.localdomain> <20051201052642.GW11266@alpha.home.local> <20051201053641.GA11928@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201053641.GA11928@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 04:36:41PM +1100, David Gibson wrote:
> On Thu, Dec 01, 2005 at 06:26:42AM +0100, Willy Tarreau wrote:
> > On Thu, Dec 01, 2005 at 11:20:49AM +1100, David Gibson wrote:
> > > Andrew, please apply
> > > 
> > > mmap() returns -EINVAL if given a zero length, and thus elf_map() in
> > > binfmt_elf.c does likewise if it attempts to map a (page-aligned) ELF
> > > segment with zero filesize.  Such a situation never arises with the
> > > default linker scripts, but there's nothing inherently wrong with
> > > zero-filesize (but non-zero memsize) ELF segments.  Custom linker
> > > scripts can generate them, and the kernel should be able to map them;
> > > this patch makes it so.
> > 
> > David, 2.4 has exactly the same code, do you see anything wrong with
> > applying this patch to 2.4 too ?
> 
> Nothing that I can think of.

Thanks, I'm queueing it for -hf and will resend it to Marcelo if he
misses it.

Regards,
Willy

