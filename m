Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbUBCPxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUBCPxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:53:40 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:32642 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266016AbUBCPx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:53:27 -0500
Date: Tue, 3 Feb 2004 16:02:23 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       Tomas Zvala <tomas@zvala.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0402031018170.31411@chaos>
References: <20040203131837.GF3967@aurora.fi.muni.cz>
 <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz>
 <Pine.LNX.4.53.0402031018170.31411@chaos>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's not what he said and, I assure you that if he unmounted
> it there would not be any buffers to flush. Execute `man umount`.

I think the original poster was referring to the cache on the device.

I.E.

mount disc
view contents
unmount disc
erase disc - but don't erase the CD-R drive's cache of the media
mount disc
view old contents of the media from the CD-R drive's cache

However, note that the disc was fast erased - according to the
cdrecord manual page, only the PMA, TOC, and pregap are erased.
Therefore, as long as these are cached by the device, user data could
theoretically still be read directly from the media.

John.
