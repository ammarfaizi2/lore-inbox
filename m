Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266510AbUFVBVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266510AbUFVBVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 21:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUFVBVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 21:21:55 -0400
Received: from bay17-f31.bay17.hotmail.com ([64.4.43.81]:61449 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266510AbUFVBVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 21:21:53 -0400
X-Originating-IP: [69.104.143.247]
X-Originating-Email: [jayrusman@hotmail.com]
From: "Jason Mancini" <jayrusman@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Via C3-2 stepping 6.9.5 + VT8235 ide/dma/network hang
Date: Mon, 21 Jun 2004 18:21:52 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY17-F31e1xkEfkuBZ00013b6e@hotmail.com>
X-OriginalArrivalTime: 22 Jun 2004 01:21:52.0994 (UTC) FILETIME=[4CC82420:01C457F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi, I'm using Mandrake cooker kernel 2.6.7-0rc3.1 on a
>Via Epia/Eden M10000N Nehemiah board with 512MB ram
>and a udma5-capable harddrive.  Looks like the
>active drivers are vt82cxxx 3.38 and via-rhine.
>
>1) heavy disk activity: works great for hours (hdparm -m16 -c1 -u1 -d1 
>-X66)
>2) heavy disk activity + network load: hangs and resets, or hangs hard,
>generally within minutes.

Ok, I did *5* things and one of them must be the culprit, place your bets!  
;-)

1) used gcc 3.3.2-7mdk instead of 3.4.1-0.3mdk
2) enabled regparm
3) enabled preempt
4) -fomit_frame_pointer (config_frame_pointer=no)
5) changed cpu from i586 to C3-2 (i686)

The stock devel RPM kernel seems to work wonderfully, I'm just a few 
compiles away...

Many Thanks!
Jason Mancini

_________________________________________________________________
Watch the online reality show Mixed Messages with a friend and enter to win 
a trip to NY 
http://www.msnmessenger-download.click-url.com/go/onm00200497ave/direct/01/

