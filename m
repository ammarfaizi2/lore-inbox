Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTKBI2l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 03:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTKBI2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 03:28:41 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:35433 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261563AbTKBI2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 03:28:40 -0500
Date: Sun, 2 Nov 2003 10:28:27 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide write cache issue? [Re: Something corrupts raid5 disks slightly during reboot]
Message-ID: <20031102082827.GO4868@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20031101210223.GM4640@niksula.cs.hut.fi> <Pine.LNX.4.10.10311012201421.23682-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10311012201421.23682-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 10:05:31PM -0800, you [Andre Hedrick] wrote:
> 
> I added the flush code to flush a drive in several places but it got
> pulled and munged.
> 
> The original model was to flush each time a device was closed, when any
> partition mount point was released, and called by notifier.
> 
> In a minimal partition count of 1, you had at least two flush before
> shutdown or reboot.
> 
> So it was not the code because I fixed it, but then again I am retiring
> from formal maintainership.

Thanks, Andre :(.

As an^Wthe IDE expert, can you clarify a few points:

  - How long can the unwritten data linger in the drive cache if the drive
    is otherwise idle? (Without an explicit flush and with write caching
    enabled.)

    I had unmounted the fs an raidstopped the md minutes before the boot.

  - Can this corruption happen on warmboot or only on poweroff?

  - What kind of corruption can one see the if boot takes place "too fast"
    and drive hasn't got enough time to flush its cache?



-- v --

v@iki.fi
