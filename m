Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUAHEJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 23:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbUAHEJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 23:09:20 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:51863 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S263642AbUAHEJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 23:09:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: Rusty Russell <rusty@rustcorp.com.au>,
       Omkhar Arasaratnam <omkhar@rogers.com>
Subject: Re: [PATCH] drivers/scsi/advansys.c check_region() fix
Date: Wed, 7 Jan 2004 23:09:14 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20040108002255.69A532C46A@lists.samba.org>
In-Reply-To: <20040108002255.69A532C46A@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401072309.14401.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.61.108] at Wed, 7 Jan 2004 22:09:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 January 2004 18:26, Rusty Russell wrote:
>In message <20031230134433.GA22187@omkhar.ibm.com> you write:
>> Another trivial check_region() fix verified by Gene
>
>And almost certainly wrong.

I'm the "Gene", Rusty.  What symptoms would I see if its wrong?  
Memory leak?  Instability?  My dog falls over before his time?  My 
pickup throws a rod?

In my case, its only running a small 4 tape Seagate changer, so it 
doesn't get a lot of exersize other than by amanda's nightly run.

>The *point* of request_region() is that you do it before any I/O to
>the region.
>
>So you can't release it before calling AscGetChipVersion().
>
>Converting this driver is quite a bit of work, since you have to
> trace down every path which uses the region and make sure it's
> covered.  The fact that it's formatted like an angry haiku doesn't
> help.

I noticed, gawd, that looks like a bowl of spagetti and I'm nowhere 
near the coder you fellows are.  But it did get rid of the compiler 
warnings about check_region().

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

