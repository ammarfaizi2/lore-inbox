Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286316AbRLJR25>; Mon, 10 Dec 2001 12:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286324AbRLJR2h>; Mon, 10 Dec 2001 12:28:37 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:43177 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286316AbRLJR2e>; Mon, 10 Dec 2001 12:28:34 -0500
Date: Mon, 10 Dec 2001 12:26:42 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <2953042101.1007975389@mbligh.des.sequent.com>
Message-ID: <Pine.LNX.4.20.0112101226240.17940-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Martin J. Bligh wrote:

> >> > I was hoping for something more elegant, but I am not adverse to writing
> >> > my own get_free_page_from_range().
> >> 
> >> Thats not a trivial task.
> > 
> > Better than giving up.. Unfortunately looking around in
> > linux/Documentation and drivers did not yield much in terms of
> > explanation. I know I can use mem_map_reserve to reserve a page but I
> > don't know how to get page struct from a physical address nor which lock
> > to use when messing with this.
> 
> If you don't have any ISA DMA going on in the system, you might consider
> bastardising the ZONE_DMA page range by moving the boundary up to
> 64Mb, then fixing the allocator not to fail back ZONE_NORMAL et al 
> allocations to ZONE_DMA. Thus what was originally ZONE_DMA becomes 
> a sort of ZONE_NO_DMA. Not in the slightest bit pretty, but it might be easier 
> to implement. Depends if you ever want it to get back into the main tree,
> I guess ;-)

Won't work - this is for general public..

                         Vladimir Dergachev

> 
> M.
> 

