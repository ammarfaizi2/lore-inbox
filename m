Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292880AbSCFBVs>; Tue, 5 Mar 2002 20:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292901AbSCFBV3>; Tue, 5 Mar 2002 20:21:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44300 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292879AbSCFBVP>;
	Tue, 5 Mar 2002 20:21:15 -0500
Message-ID: <3C856EA1.A88F9EA4@zip.com.au>
Date: Tue, 05 Mar 2002 17:19:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from ext2_get_block() version 2
In-Reply-To: <Pine.GSO.4.21.0203051935160.18755-100000@weyl.math.psu.edu> <3C856818.4050005@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Alexander Viro wrote:
> > Denied.  You can trivially do that in ext2_read_inode() and ext2_new_inode().
> Good point.  That makes it much easier.
> 
> > ext2 patches _MUST_ get testing in 2.5 before they can go into 2.4.  At
> > the very least a month, preferably - two.  Until then consider them vetoed
> > for 2.4, no matter how BKL brigade feels about their crusade.
> ChangeSet@1.290  2002-02-11 21:26:50-08:00  viro@psu.edu
> 
> So, it has been almost a month.  Do you plan to port these changes back
> to 2.4 yourself?
> 

2.5.5's ext2 has an SMP race, probably in get_block, which results in
the freeing of already-free buffers.   That has not yet been found and
fixed.

-
