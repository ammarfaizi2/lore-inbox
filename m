Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTKQDy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 22:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTKQDy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 22:54:27 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:7610 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261762AbTKQDyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 22:54:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Andrew Morton <akpm@osdl.org>, Gawain Lynch <gawain@freda.homelinux.org>
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
Date: Sun, 16 Nov 2003 22:54:23 -0500
User-Agent: KMail/1.5.1
Cc: prakashpublic@gmx.de, linux-kernel@vger.kernel.org, cat@zip.com.au
References: <20031116192643.GB15439@zip.com.au> <1069035604.1916.3.camel@frodo.felicity.net.au> <20031116184925.43c8b481.akpm@osdl.org>
In-Reply-To: <20031116184925.43c8b481.akpm@osdl.org>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311162254.23043.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.12.17] at Sun, 16 Nov 2003 21:54:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 November 2003 21:49, Andrew Morton wrote:
>Gawain Lynch <gawain@freda.homelinux.org> wrote:
>> On Mon, 2003-11-17 at 08:42, Andrew Morton wrote:
>> > Two things to try, please:
>> >
>> > a) Is the problem from Linus's tree?  Try 2.6.0-test9 plus
>> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
>> >.6.0-test9/2.6.0-test9-mm3/broken-out/linus.patch
>> >
>> > b) The only significant scheduler change in mm3 was
>> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2
>> >.6.0-test9/2.6.0-test9-mm3/broken-out/context-switch-accounting-f
>> >ix.patch
>> >
>> >    So please try -mm3 with the above patch reverted with
>> >
>> > 	patch -R -p1 < context-switch-accounting-fix.patch
>>
>> Hi Andrew,
>>
>> This is also easily reproducible here with just a kernel compile.
>>
>> I have tried both a) and b) with b) not changing anything, but a)
>> seems to work...  Anything more to try?
>
>Your report has totally confused me.  Are you saying that the
> jerkiness is caused by linus.patch?  Or not?  Pleas try again ;)

In defense of this code, I ran -mm3 with the deadline elevator for 
about 3 days and was very happy with the interactivity.  Now I've 
been running with the elevator=cfq for most of the day, and it also 
seems to be pretty responsive.  The default as wasn't, at least for 
-mm2, and I haven't tried it yet for -mm3.  Should I, and report back 
in a day or so so that you've got reports from an otherwise identical 
system to compare?

We need a test suite for this :)

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

