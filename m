Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbULBUTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbULBUTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbULBUTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:19:10 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:62647 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S261756AbULBUS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:18:59 -0500
Date: Thu, 02 Dec 2004 22:18:53 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: Designing Another File System
In-reply-to: <cce9e37e041130112243beb62d@mail.gmail.com>
To: Phil Lougher <phil.lougher@gmail.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Message-id: <200412022218.54182.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <41ABF7C5.5070609@comcast.net>
 <cce9e37e041130112243beb62d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 November 2004 21:22, Phil Lougher wrote:

> I've had people trying to store 500,000 + files in a Squashfs
> directory.  Needless to say with the original directory implementation
> this didn't work terribly well...

My old-style newsspool longs for a fast filesystem. Once I did something
stupid, did a backup with mkisofs, and tried a ls -lR on the resulting CD.
After a few hours, I decided that I needed the box to do some work instead
of the 100% uninterruptable sys cpu usage, and rebooted it. I wonder how
long that operation would've taken on isofs :) Mind, the cd drive wasnt really
active during that time, so it wasn't an issue of seek-limited IO blocking
the ide bus.

Tried to store it in a zisofs in later days on more recent kernels for morbid
curiosity, and while it didn't effectively hang the machine anymore, it didn't
work terribly well either...

Currently the thing lives on a Reiser3 partition, previously ext3. They seem
to be about the same speed for this in practice. A "du -sh" takes about 15
minutes to execute, tarring it into a tar.bz2 seems to take about as long as
that, too. Using Theodore Tso's spd_readdir.c, the tar backup case ran in
5 minutes once upon a time. spr_readdir throws segfaults at me now with
2.6 kernels though :-(
