Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUFKNkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUFKNkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 09:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUFKNkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 09:40:17 -0400
Received: from mail.aei.ca ([206.123.6.14]:23277 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263928AbUFKNkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 09:40:10 -0400
Subject: Re: [PATCH][2.6.7-rc3] Single Priority Array CPU Scheduler
From: Shane Shrybman <shrybman@aei.ca>
To: pwil3058@bigpond.net.au
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1086961198.2787.19.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 11 Jun 2004 09:39:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I just started to try out your SPA scheduler patch and found that it is
noticeably sluggish when resizing a mozilla window on the desktop. I
have a profile of 2.6.7-rc3-spa and 2.6.7-rc2-mm2 and put them up at:
http://zeke.yi.org/linux/spa/ . There is also vmstat output there but it
doesn't look too helpful to me.

The test was basic and went like this:

x86, K7, UP, gnome desktop with mozilla (with a bunch of tabs) and a few
rxvts. cmdline= elevator=cfq profile=1

readprofile -r

grab a corner of my mozilla window and continually move it around for
several seconds

readprofile -v -m /boot/System.map-2.6.7-rc3|sort -rn +2|head -n30

do the same while dumping vmstat 1 to a file.

The kernel with your patch had a much harder time keeping up with the
window resizing. Moving the entire window did not seem too bad or not
too noticeable. I tried a similar test while running a kernel compile
(make -j3) and it made the window resizing _really_ slow to respond.

Regards,

Shane





