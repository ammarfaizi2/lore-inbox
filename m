Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314413AbSDZXBS>; Fri, 26 Apr 2002 19:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314484AbSDZXBS>; Fri, 26 Apr 2002 19:01:18 -0400
Received: from [195.223.140.120] ([195.223.140.120]:62066 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314413AbSDZXBR>; Fri, 26 Apr 2002 19:01:17 -0400
Date: Sat, 27 Apr 2002 01:01:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: hgchewml@optusnet.com.au,
        "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
        riel@conectiva.com.br
Subject: Re: File corruption when running VMware.
Message-ID: <20020427010134.M19278@dualathlon.random>
In-Reply-To: <37A7BD60863@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 05:30:37PM +0200, Petr Vandrovec wrote:
> On 24 Apr 02 at 2:01, Rik van Riel wrote:
> > On Wed, 24 Apr 2002, Hong-Gunn Chew wrote:
> > 
> > > I have a repeatable problem when running VMware workstation 3.00 and
> > > 3.01.  The cause is still unknown, and could be VMware itself, the
> > > hardware or the kernel.
> > 
> > If you can reproduce it without VMware or with only the
> > open source part of VMware (ie without any of the binary
> > only parts) we might have a chance of debugging it.
> 
> Hi again,
>   one of 2.4.x kernel images available in SuSE's 8.0 has patched&enabled 
> support for page tables in high memory, and this quickly revealed
> incompatibility between VMware's vmmon page table handling and
> ptes above directly mapped range.
> 
>   So if you have >890MB of RAM and your kernel is compiled with support
> for pte in high memory, please stop using VMware, or reconfigure your 
> kernel to not use pte in high memory (4GB config without pte-in-highmem
> is OK). Using pte-in-highmem with vmmon will cause kernel oopses and/or 

passing to the kernel mem=850M in lilo at boot will be enough.

> memory corruption :-(
> 
>   If you do not have >890MB of memory, then reason for your memory corruption
> is still unknown to me.
>                                           Best regards,
>                                                     Petr Vandrovec
>                                                     vandrove@vc.cvut.cz
>                                                     
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
