Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317309AbSFGQwb>; Fri, 7 Jun 2002 12:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317310AbSFGQwa>; Fri, 7 Jun 2002 12:52:30 -0400
Received: from p50886B5E.dip.t-dialin.net ([80.136.107.94]:22401 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317309AbSFGQw2>; Fri, 7 Jun 2002 12:52:28 -0400
Date: Fri, 7 Jun 2002 10:52:22 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: akpm@zip.com.au, <axboe@suse.de>, <colpatch@us.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's
 bigger than queue could handle
In-Reply-To: <200206071246.FAA06400@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0206071050570.15675-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Jun 2002, Adam J. Richter wrote:
> 	int max_phys = parent->childqueue[0].max_phys_segments;
> 	int max_hw = parent->childqueue[0].max_hw_segments;
> 	int max_sec = parent->childqueue[0].max_sectors;

> 	for (i = 1; i < parent->num_children; i++) {
> 	   max_phys = min(max_phys, parent->childqueue[0].max_phys_segments);
> 	   max_hw = min(max_hw, parent->childqueue[0].max_hw_segments);
> 	   max_sec = min(max_sec, parent->childqueue[0].max_sectors);
> 	}

Just a question: Did you mean parent->childqueue[0] here, or rather 
parent->childqueue[i]?

> 	blk_queue_max_phys_segments(&parent->queue, max_phys);
> 	blk_queue_max_hw_segments(&parent->queue, max_hw);
> 	blk_queue_max_sectors(&parent->queue, max_sec);

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

