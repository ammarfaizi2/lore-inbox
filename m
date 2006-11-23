Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWKWAKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWKWAKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 19:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757209AbWKWAKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 19:10:31 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:27795 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1757186AbWKWAKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 19:10:31 -0500
Date: Thu, 23 Nov 2006 01:10:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
In-Reply-To: <ek2nva$vgk$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0611230107240.26845@yvahk01.tjqt.qr>
References: <ek2nva$vgk$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi!
>
>(PEBKAC warning. I'm probably doing something dump. I just don't know
>what...)
>
>I seem to have an entropy pool on a headless machine which is not nearly
>empty (a common problem in this case, I know), but completely empty and
>stuck in this state...
>
>Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
>0

You really must have bad luck with your entropy...


01:05 ichi:/home/k > cat /proc/sys/kernel/random/entropy_avail
3596
01:08 ichi:/home/k > dd if=/dev/urandom of=/dev/null bs=3596 count=1
1+0 records in
1+0 records out
3596 bytes (3.6 kB) copied, 0.00115262 seconds, 3.1 MB/s
01:08 ichi:/home/k > cat /proc/sys/kernel/random/entropy_avail
157

however that might be caused because I am in X, mouse moves, kernel 
compiles, etc.


>Also causing disk activities doesn't help at all. (Two disks on a Promise
>PDC20268 controller.)

Disk activities are "somewhat predictable", like network traffic, and 
hence are not (or should not - have not checked it) contribute to the 
pool. Note that urandom is the device which _always_ gives you data, and 
when the pool is exhausted, returns pseudorandom data.


>The system runs a rather ancient Debian Sarge 2.4 kernel:
>Linux Hornburg 2.4.27-3-386 #1 Thu Sep 14 08:44:58 UTC 2006 i486 GNU/Linux

[I have] No memories about a kernel this old. :>

>However as the machine itself is also ancient, the 2.4 seems like a good
>match. And also 2.4 ought to have a refilling entropy pool, doesn't it?
>
>Maybe someone can shed some light on what's happening here...


	-`J'
-- 
