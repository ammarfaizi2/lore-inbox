Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283054AbRLDP06>; Tue, 4 Dec 2001 10:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283080AbRLDOmW>; Tue, 4 Dec 2001 09:42:22 -0500
Received: from pD903CA3E.dip.t-dialin.net ([217.3.202.62]:63390 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S283554AbRLDNVz>; Tue, 4 Dec 2001 08:21:55 -0500
Date: Tue, 4 Dec 2001 14:20:47 +0100
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tuning ext2 or ReiserFS to avoid fragmentation with large files?
Message-ID: <20011204142047.N11967@no-maam.dyndns.org>
In-Reply-To: <Pine.LNX.4.30.0112031404030.7944-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0112031404030.7944-100000@mustard.heime.net>
User-Agent: Mutt/1.3.23i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2001 at 02:13:22PM +0100, Roy Sigurd Karlsbakk wrote:
> hi all
> 
> I've got this server with lots of ~3GB files and every now and then we
> need to add some more or delete some old ones. All files are potentially
> read concurrently, so to reduce disk seeks, I've increased the readahead
> settings in kernel (/proc/sys/vm/(min|max)-readahead).
> 
> Then... A friend of mine told me I could tune the fs (or vfs) to allocate
> n kB each time a file is created, and by setting this to whatever I've set
> (min|max)-readahead to (currently 1048576), I will reduce the negative
> effect of fragmentation to a minimum, since the data blocks will be large,
> and read more-or-less sequencially.
> 
> Can anyone tell me how to tell the fs or the kernel to allocate n pages/kB
> this way? Is it possible? Can I possibly set different sizes per file
> system?

If I remember right xfs has got a online-defragmentation utility. So
have a look at xfs.

I think xfs works different from reiserfs and ext2 when writing files to
disk which helps avoiding fragmentation. This feature is called
allocation groups.
