Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTL1V4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 16:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTL1V4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 16:56:46 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:33412 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262094AbTL1V4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 16:56:45 -0500
Date: Sun, 28 Dec 2003 22:56:44 +0100
From: bert hubert <ahu@ds9a.nl>
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>, linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Message-ID: <20031228215644.GA32140@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>,
	Joel Jaeggli <joelja@darkwing.uoregon.edu>,
	linux-kernel@vger.kernel.org
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <Pine.LNX.4.44.0312281032350.21070-100000@twin.uoregon.edu> <20031228213535.GA21459@mail-infomine.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228213535.GA21459@mail-infomine.ucr.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 01:35:35PM -0800, Johannes Ruscheinski wrote:

> Fisrt of all: thanks for the advice Joel!  Two questions: why not use the
> hardware raid capability of the Promise tx4000 and if we'd use software
> raid instead, what would be the CPU overhead?

For the cost differential between linux native RAID and an external device
of similar capabilities, outfit yourself with an additional CPU. I don't use
RAID5 a lot but to a modern CPU, checksumming dozens of megabytes/second is
child's play:

raid5: measuring checksumming speed
   8regs     :  1479.600 MB/sec
   32regs    :   744.400 MB/sec
   pIII_sse  :  1649.200 MB/sec
   pII_mmx   :  1806.000 MB/sec
   p5_mmx    :  1915.200 MB/sec
raid5: using function: pIII_sse (1649.200 MB/sec)

This is on a 800MHz Celeron, so a recent >2Ghz system will do lots better
still.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
