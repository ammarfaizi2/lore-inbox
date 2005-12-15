Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVLOS5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVLOS5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVLOS5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:57:41 -0500
Received: from sa2.bezeqint.net ([192.115.104.16]:25064 "EHLO sa2.bezeqint.net")
	by vger.kernel.org with ESMTP id S1750907AbVLOS5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:57:40 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: Eric Sandeen <sandeen@sgi.com>
Subject: Re: XFS Mount Hangs the Partition (on latest kernel + many old 2.6.x ones)
Date: Thu, 15 Dec 2005 20:50:57 +0200
User-Agent: KMail/1.8.2
Cc: Nathan Scott <nathans@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
References: <200512071357.39121.shlomif@iglu.org.il> <200512151953.16931.shlomif@iglu.org.il> <43A1B63F.4030404@sgi.com>
In-Reply-To: <43A1B63F.4030404@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512152050.57961.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 December 2005 20:30, Eric Sandeen wrote:
> Shlomi Fish wrote:
> > Replying to myself, I'd like to ask for a response to my previous
> > message, especially the order in which the operations Mr. Scott mentioned
> > need to be performed.
> >
>  >>>- get sysrq-t information for all hung processes, esp. mount;
>  >>>- send xfs_info output for the filesystem in question;
>  >>>- dump the log (xfs_logprint -C) and send it to us.
>
> xfs_logprint -C /dev/foo against the unmounted device.
>
> sysrq-t when it's hung, after you try to mount
>
> xfs_info /mnt/point when it's mounted.
>
> Well, you can't mount, because recovery hangs, so,
>
> mount -o ro,norecovery /dev/foo /mnt/point; xfs_info /mnt/point
>
> -Eric

Thanks!

I'll save this message to a file, put it on different partitions and print it 
in case this problem repeats itself.

Regards,

	Shlomi Fish

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

95% of the programmers consider 95% of the code they did not write, in the
bottom 5%.
