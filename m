Return-Path: <linux-kernel-owner+w=401wt.eu-S932244AbWLSOeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWLSOeW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 09:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWLSOeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 09:34:22 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:23854 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbWLSOeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 09:34:22 -0500
X-Greylist: delayed 1875 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 09:34:21 EST
Message-ID: <4587F113.2000804@tls.msk.ru>
Date: Tue, 19 Dec 2006 17:02:59 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: Wiebe Cazemier <halfgaar@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Software RAID1 (with non-identical discs) performance
References: <em0pdq$r7o$2@sea.gmane.org> <em8lim$lqd$1@sea.gmane.org>
In-Reply-To: <em8lim$lqd$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiebe Cazemier wrote:
> For some reason, your message doesn't appear in the GMane mail-to-news gateway.
> I've quoted your message here. Hopefully, the quoting isn't messed up.
> 
>> The entire concept of geometry is a a carryover from days gone by. These days
> it is just a farse maintained for backwards compatibility. You can put fdisk
> into sector mode with the 'u' command and create partitions of any number of
> sectors you desire, regardless of the perceived geometry.
[]
> My concern wasn't so much about the different speeds of the drives, but the
> fact that they have a different geometry. But, because you said that is
> simulated anyway, can I assume that as long as both drives are equal in speed,
> using different types of drives doesn't matter?

Think of "PnP geometry" supported by all nowadays drives.

It's 255 heads, 63 sectors per track, and whatever number of cylinders.

You start cfdisk (sorry don't remember options for other *fdisk) like this,
on an empty disk:

  cfdisk -H 255 -S 63 /dev/sda

And after creating the partition table, kernel switches to this "PnP geometry"
mode automatically.

So regardless of how many actual heads or sectors your HDD has, it will always
work the same way.

/mjt
