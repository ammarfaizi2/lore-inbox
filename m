Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUGaPgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUGaPgb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 11:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267956AbUGaPgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 11:36:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52435 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267702AbUGaPg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 11:36:26 -0400
Date: Sat, 31 Jul 2004 17:36:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Zinx Verituse <zinx@epicsol.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems
Message-ID: <20040731153609.GG23697@suse.de>
References: <20040730193651.GA25616@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730193651.GA25616@bliss>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30 2004, Zinx Verituse wrote:
> I'm going to bump this topic a bit, since it's been a while..
> There are still some issues with ide-cd's SG_IO, listed from
> most important as percieved by me to least:
> 
>  * Read-only access grants you the ability to write/blank media in the drive
>  * (with above) You can open the device only in read-only mode.

That's by design. Search linux-scsi or this list for why that is so.

>  * You can't open the device unless there is media in the drive

False, you use O_NONBLOCK.

>  * Still seems to be no way to specify scatter gather/dma buffers yourself,
>    though I'm not entirely sure that matters anyway.

That's true, later implementation of block layer SG_IO adds that as
well. It's really a minor thing though, I don't think I've ever seen
anyone use it outside of regression testing scripts.

-- 
Jens Axboe

