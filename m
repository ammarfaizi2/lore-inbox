Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTKUIYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTKUIYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:24:41 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:53444 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S264325AbTKUIYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:24:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Andrew Morton <akpm@osdl.org>, IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Subject: Re: O_DIRECT leaks memory on linux-2.6.0-test9
Date: Fri, 21 Nov 2003 03:24:35 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20031121061806.6A65F7007C@sv1.valinux.co.jp> <20031121073411.665A27007C@sv1.valinux.co.jp> <20031120235530.3d09882f.akpm@osdl.org>
In-Reply-To: <20031120235530.3d09882f.akpm@osdl.org>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311210324.35127.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.54.127] at Fri, 21 Nov 2003 02:24:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 November 2003 02:55, Andrew Morton wrote:
>IWAMOTO Toshihiro <iwamoto@valinux.co.jp> wrote:
>> It'll take a while to leak a noticable amount of memory. So I
>> reduced the amount of memory using a boot option.
>
>Well I'll be darned.  I took a new version of fsstress and it
> happens here too.  We're leaking anonymous memory.  -mm doesn't do
> any better, either.

Running 2.6.0-test9-mm4, default as scheduler

That triggerd me to go look at ksysguard, and I've got 70 megs out in 
swap in less than 24 hours uptime with my normal loading.  Usually it 
takes me a couple of weeks to get that much as I've half a gig of 
main memory.  Its also showing about 95 megs free.  Would this leak 
show up there (ksysguard), and if so, in what section?

T'would be nice if xosview were to be made operable, but this kernel 
breaks it.  I used to keep it running in the corner of one of my 
screens.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

