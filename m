Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755436AbWKNIO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbWKNIO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755443AbWKNIO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:14:58 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:59285 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1755436AbWKNIO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:14:57 -0500
Message-ID: <45597B0A.3060409@drzeus.cx>
Date: Tue, 14 Nov 2006 09:15:06 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk>
In-Reply-To: <20061114075648.GK15031@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>
> There is no helper to kill already queued requests when a device is
> removed, if you look at SCSI you'll see that it handles this "manually"
> as well in the request_fn handler. So you'll need a "device dead or
> gone" check in your request_fn handler, and do it from there.
>
>   

Is there some part of the current infrastructure I can use to determine
this. If del_gendisk() grabs the queue lock (and hence is "safe" wrt the
request handler), then perhaps there is a test that can be done to test
if the disk has been deleted?

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

