Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWJNOkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWJNOkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 10:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbWJNOkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 10:40:11 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:31377 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1752169AbWJNOkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 10:40:10 -0400
From: Matthias Dahl <mlkernel@mortal-soul.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: sluggish system responsiveness under higher IO load
Date: Sat, 14 Oct 2006 16:39:57 +0200
User-Agent: KMail/1.9.5
Cc: Jens Axboe <axboe@suse.de>, Mike Galbraith <efault@gmx.de>,
       linux-kernel@vger.kernel.org
References: <200608061200.37701.mlkernel@mortal-soul.de> <200608131815.12873.mlkernel@mortal-soul.de> <20061006175833.4ef08f06@localhost>
In-Reply-To: <20061006175833.4ef08f06@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610141639.58374.mlkernel@mortal-soul.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 17:58, Paolo Ornati wrote:

> I used to have this type of problem and 2.6.19-rc1 looks much better
> than 2.6.18.
>
> I'm using CONFIG_PREEMPT + CONFIG_PREEMPT_BKL, CFQ i/o scheduler
> and /proc/sys/vm/swappiness = 20.

I will give 2.6.19 a test in a few weeks when the dust of all the changes have 
settled a bit. :-)

As my Mike Galbraith suggested, I made some tests with renicing the IO 
intensive applications. This indeed makes a hell of a difference. Currently I 
am renicing everything that causes a lot of disk IO to a nice of 19. Even 
though this doesn't fix it completely, the occasional short hangs have become 
less common.

Unfortunately things have gotten a bit worse again since I switched my machine 
over to a linux software RAID5 (3 sata disks attached to the nforce4 ultra) 
even though I hoped quite the opposite would happen.

Have a nice weekend,
matthew.
