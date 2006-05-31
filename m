Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWEaJej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWEaJej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 05:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWEaJej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 05:34:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41265 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964919AbWEaJei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 05:34:38 -0400
Date: Wed, 31 May 2006 11:36:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Arend Freije <afreije@inn.nl>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RAID-1 and Reiser4 issue: umount hangs
Message-ID: <20060531093644.GL29535@suse.de>
References: <4478CF33.80609@inn.nl> <17528.55008.287088.705263@cse.unsw.edu.au> <44797136.4050707@inn.nl> <17530.14115.195147.46212@cse.unsw.edu.au> <447D5F7C.8020401@inn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447D5F7C.8020401@inn.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31 2006, Arend Freije wrote:
> You're probably right. I found several posts on the linux-kernel list
> involving problems with write barrier support in combination with SATA
> and ext3 . So I tried:
> 
> # mkfs -t ext3 /dev/md/0
> # mount -o barrier=1 /dev/md/0 /mnt
> # cp -a $src /mnt
> # umount /mnt
> 
> And indeed, umount hangs now as well.
> So it seems to be a linux-kernel issue after all...

Can you please try 2.6.17-rc5?

-- 
Jens Axboe

