Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265983AbSKDIQs>; Mon, 4 Nov 2002 03:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265985AbSKDIQr>; Mon, 4 Nov 2002 03:16:47 -0500
Received: from mhost.enel.ucalgary.ca ([136.159.102.8]:47528 "EHLO
	mhost.enel.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S265983AbSKDIQr>; Mon, 4 Nov 2002 03:16:47 -0500
Date: Mon, 4 Nov 2002 01:23:19 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] how to mount ext2 partition accidentally mounted as ext3
Message-ID: <20021104012319.A12166@munet-d.enel.ucalgary.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021104075252.GA575@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021104075252.GA575@pazke.ipt>; from pazke@orbita1.ru on Mon, Nov 04, 2002 at 10:52:52AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04, 2002  10:52 +0300, Andrey Panin wrote:
> Currently I'm working on resurrection of SGI Visual Workstation support 
> for 2.5 and some progress was made last week. 
> VISWS kernel even mounts root fs now (doesn't matter thet framebuffer driver 
> can't draw anything on the screen and uhci-hcd doesn't work :))
> 
> But I made one stupid mistake: EXT3 filesystem was enabled in .config file
> used for VISWS kernel compilation. So after the first boot of this kernel,
> I found that old 2.2.10 kernel making my VISWS self hosting can't mount
> root fs complaining about nonsupported filesystem feature.
> 
> My question is how can I make this fs mountable by 2.2.10 again ?

You just need to run a modern e2fsck on the filesystem to flush the
journal and clear the "needs_recovery" flag.  Alternately mounting
it once with a 2.[45] kernel and do a clean shutdown will do the same.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
