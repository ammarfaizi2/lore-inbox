Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbTDELEE (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 06:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbTDELEE (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 06:04:04 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6160 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262024AbTDELED (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 06:04:03 -0500
Date: Sat, 5 Apr 2003 02:57:44 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: John Bradford <root@81-2-122-30.bradfords.org.uk>
cc: Nigel Cunningham <ncunningham@clear.net.nz>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fixes for ide-disk.c
In-Reply-To: <200304050927.h359RtL2000320@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.10.10304050255540.29290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are you issuing "standby" or "suspend" ?

The shutdown issues a "standby" and not a "suspend", this is why you get
the spinup on a flush-cache.

On Sat, 5 Apr 2003, John Bradford wrote:

> > People using swsusp under 2.4 found that everything worked
> > fine if they rebooted after writing the image, but powering down at the
> > end of writing the image caused corruption. I got the additional check
> > from the source for hdparm, which only does the new check to determine
> > if a drive has a writeback cache.
> 
> Did we ever establish what the best way to ensure that the write cache is
> flushed, is?  An explicit cache flush and spin down are both necessary, but
> I had problems with drives spinning back up when we did the spindown first.
> 
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

