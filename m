Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282133AbRLHQTN>; Sat, 8 Dec 2001 11:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282147AbRLHQTD>; Sat, 8 Dec 2001 11:19:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48135 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282133AbRLHQSz>;
	Sat, 8 Dec 2001 11:18:55 -0500
Date: Sat, 8 Dec 2001 17:18:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre7 ide-cd module
Message-ID: <20011208161847.GK11567@suse.de>
In-Reply-To: <3C1235C4.BC20AC8E@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1235C4.BC20AC8E@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08 2001, Pierre Rousselet wrote:
> Attached is dmesg with 2.5.1-pre7 + devfs-patch-v203.
> 
> The first and second manual loading of the ide-cd module give something
> different.
> 
> #modprobe ide-cd ; rmmod ide-cd ; modprobe ide-cd
> 
> hdc: ATAPI CD-ROM drive, 0kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA

Upon first load, could you cat /proc/sys/dev/cdrom/info? It would appear
that the drive is sending zeroed data but not reporting a failure.

Is this a new problem?

-- 
Jens Axboe

