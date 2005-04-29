Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVD2P14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVD2P14 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVD2P14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:27:56 -0400
Received: from colin.muc.de ([193.149.48.1]:1809 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262796AbVD2P1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:27:54 -0400
Date: 29 Apr 2005 17:27:48 +0200
Date: Fri, 29 Apr 2005 17:27:48 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: luming.yu@intel.com, linux-kernel@vger.kernel.org, racing.guo@intel.com
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
Message-ID: <20050429152748.GA38331@muc.de>
References: <200504261327.30928.luming.yu@intel.com> <20050427123852.GD12597@muc.de> <20050427113800.6be34642.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427113800.6be34642.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 11:38:00AM -0700, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > On Tue, Apr 26, 2005 at 01:27:30PM +0800, Yu, Luming wrote:
> > > 
> > > Forward a patch :
> > 
> > Some comments: 
> > 
> > The asmlinkage on x86-64 is not really needed. You can remove
> > the ifdef. fastcall is fine, although it is a nop.
> > 
> > The u64 tsc[NR CPUS] on the stack is a stack overflow with big
> > NR_CPUS. I have
> > a patch locally here to fix it, but you could just apply it
> > anyways when you move the code. Fix is to use kmalloc here.
> > 
> 
> OK, thanks.  Luming, could you please reissue the second patch, including
> the above fixes as well as the two warning fixes which we discussed?

Another comment: 

If Luming would not move the mce.c file from x86-64 to i386 then
his patch would be only 1/4 as big. I dont know why he does this
anyways, it seems completely pointless.


-Andi

> 
