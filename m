Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbTCYGgf>; Tue, 25 Mar 2003 01:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbTCYGgf>; Tue, 25 Mar 2003 01:36:35 -0500
Received: from verein.lst.de ([212.34.181.86]:29203 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261474AbTCYGge>;
	Tue, 25 Mar 2003 01:36:34 -0500
Date: Tue, 25 Mar 2003 07:47:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: !CONFIG_MMU stubs in 2.5.66
Message-ID: <20030325074739.A16342@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
References: <buod6kgaxhb.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <buod6kgaxhb.fsf@mcspd15.ucom.lsi.nec.co.jp>; from miles@lsi.nec.co.jp on Tue, Mar 25, 2003 at 01:20:16PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 01:20:16PM +0900, Miles Bader wrote:
> The following change in 2.5.66:
> 
>    [PATCH] a few missing stubs for !CONFIG_MMU
> 
>    Patch from Christoph Hellwig <hch@lst.de>
> 
>    This is from the uClinux patches - there are a few more stubs needed
>    in nommu.c to get the mmuless plattforms working.
> 
> Adds definitions for vmalloc_to_page, follow_page, and remap_page_range,
> to mm/mmnommu.c.  However, there are already inline definitions of those
> functions (predicated on !CONFIG_MMU) in linux/mm.h, so compilation
> fails.
> 
> Which is the correct location?

OOPS, it looks like Greg & me submitted paches in parallel.  Personally I
prefer the out of line ones over the inlines, especially as they handle
vmalloc_to_page properly.  I'll submit a patch to Linus to fix this
mess.

