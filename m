Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUATUBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUATUBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:01:32 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:15365 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265783AbUATUBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:01:30 -0500
Date: Tue, 20 Jan 2004 21:01:23 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for ide-scsi crash
Message-ID: <20040120210123.A1528@pclin040.win.tue.nl>
References: <Pine.LNX.4.44.0401201801190.1508-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0401201801190.1508-100000@neptune.local>; from der.eremit@email.de on Tue, Jan 20, 2004 at 06:08:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 06:08:44PM +0100, Pascal Schmidt wrote:

> I have a question about cdrom_start_read_continuation:
> 
> Variables called nframes and frames are computed but never used. Only
> nskip actually gets factored into the request:
> 
> 	rq->current_nr_sectors += nskip;
> 
> The others are local vars and never get assigned to anything more
> global. So I conclude they are meaningless? I ask because this
> is one of the places that uses SECTORS_PER_FRAME and it doesn't make
> sense to me.

Yes, they are meaningless.
The code that used them was removed in 2.5.1.

