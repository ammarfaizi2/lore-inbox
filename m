Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267324AbSLENyV>; Thu, 5 Dec 2002 08:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267325AbSLENyV>; Thu, 5 Dec 2002 08:54:21 -0500
Received: from verein.lst.de ([212.34.181.86]:36624 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267324AbSLENyU>;
	Thu, 5 Dec 2002 08:54:20 -0500
Date: Thu, 5 Dec 2002 15:01:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Michael <soppscum@online.no>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.47-xfs[cvs] Oops when mounting ISO image.
Message-ID: <20021205150149.A26946@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Hugh Dickins <hugh@veritas.com>, Michael <soppscum@online.no>,
	linux-kernel@vger.kernel.org
References: <20021205132649.5be6fded.soppscum@online.no> <Pine.LNX.4.44.0212051316550.1405-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0212051316550.1405-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Dec 05, 2002 at 01:36:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 01:36:27PM +0000, Hugh Dickins wrote:
> If your xfs[cvs] resembles the xfs source in 2.5.50-mm1, then it looks
> to me like fs/xfs/linux has a .sendfile = linvfs_sendfile in xfs_file.c
> (which assures the loop driver it can loop this file for reading), but
> lacks a .vop_ioctl = xfs_sendfile (and its extern) in xfs_vnodeops.c.
> 
> But I've not delved into XFS, for all I know that code may not be ready
> to use yet: Christoph can say.

I've still had a few issues with the sendfile code.  I hope I can get
it working very soon.  One of the problems is that the xfss tree is
still at 2.5.47 and needs the below fix.  If only the module mess in
mainline could get sorted out a bit more..

