Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbUBYVVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUBYVTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:19:55 -0500
Received: from winds.org ([68.75.195.9]:16026 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S261594AbUBYVTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:19:22 -0500
Date: Wed, 25 Feb 2004 16:19:17 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-kernel@vger.kernel.org
cc: axboe@image.dk
Subject: How to force cdrom driver to redetect media after cdrecord?
Message-ID: <Pine.LNX.4.58.0402251611590.6015@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I originally thought so, but maybe I was wrong. Jens posted a patch
> > to invalidate kernel buffers on an umount - if the problem persists
> > with that patch, I still believe it is a hardware fault.
>
> Perhaps another program has the device open still? In that case, we
> don't invalidate the toc cache.
>
> --
> Jens Axboe

Jens,
I ran into something similar today. I'd like to use cdrecord to write to a CD
and then immediately turn around and read from it for verification purposes...

...Except that I only get 2048 bytes from a 'cat /dev/scd0' until I take the CD
out and put it back in.

Is there a known way for a userland application to make an ioctl to the cdrom
device in a 2.4/2.6 kernel to tell it the media changed without forcing a tray
open & close?

I intend to execute a program with this ioctl (if there is such a thing) after
the cdrecord and before the 'cat'.

Thanks,
 -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
