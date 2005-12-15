Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVLOSag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVLOSag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVLOSag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:30:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50588 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750889AbVLOSaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:30:35 -0500
Message-ID: <43A1B63F.4030404@sgi.com>
Date: Thu, 15 Dec 2005 12:30:23 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shlomi Fish <shlomif@iglu.org.il>
CC: Nathan Scott <nathans@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: XFS Mount Hangs the Partition (on latest kernel + many old 2.6.x
 ones)
References: <200512071357.39121.shlomif@iglu.org.il> <20051208075512.F7282696@wobbly.melbourne.sgi.com> <200512081755.58078.shlomif@iglu.org.il> <200512151953.16931.shlomif@iglu.org.il>
In-Reply-To: <200512151953.16931.shlomif@iglu.org.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shlomi Fish wrote:
> Replying to myself, I'd like to ask for a response to my previous message, 
> especially the order in which the operations Mr. Scott mentioned need to be 
> performed.

 >>>- get sysrq-t information for all hung processes, esp. mount;
 >>>- send xfs_info output for the filesystem in question;
 >>>- dump the log (xfs_logprint -C) and send it to us.


xfs_logprint -C /dev/foo against the unmounted device.

sysrq-t when it's hung, after you try to mount

xfs_info /mnt/point when it's mounted.

Well, you can't mount, because recovery hangs, so,

mount -o ro,norecovery /dev/foo /mnt/point; xfs_info /mnt/point

-Eric

