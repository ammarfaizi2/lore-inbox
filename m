Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTLQQTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264470AbTLQQTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:19:51 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:28837 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S264467AbTLQQTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:19:47 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Thomas Voegtle <thomas@voegtle-clan.de>, linux-kernel@vger.kernel.org
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
Date: Wed, 17 Dec 2003 11:19:39 -0500
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.21.0312171604390.32339-100000@needs-no.brain.uni-freiburg.de>
In-Reply-To: <Pine.LNX.4.21.0312171604390.32339-100000@needs-no.brain.uni-freiburg.de>
Organization: Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200312171119.39966.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.60.44] at Wed, 17 Dec 2003 10:19:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 December 2003 10:09, Thomas Voegtle wrote:
>Hello,
>
>cdrecord -dev=ATAPI -scanbus  with 2.6.0-test11-bk10 and bk13 shows
> this:
>
>scsibus0:
>        0,0,0     0) '' '' '' NON CCS Disk
>        0,1,0     1) '' '' '' NON CCS Disk
>
>
>but this works well with 2.6.0-test11.
>=>
>
>        0,0,0     0) 'CREATIVE' ' CD5233E        ' '2.05' Removable
> CD-ROM 0,1,0     1) 'PLEXTOR ' 'CD-R   PX-W1610A' '1.04' Removable
> CD-ROM
>
>SuSE 9.0

The above looks ok, but even though I'm working with 2.6.0-test11, 
that command gets this:

[root@coyote amanda-dbg]# cdrecord -dev=ATAPI -scanbus
Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg 
Schilling
scsidev: 'ATAPI'
devname: 'ATAPI'
scsibus: -2 target: -2 lun: -2
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.7'
scsibus0:
        0,0,0     0) 'CREATIVE' 'CD-RW RW1210E   ' 'LCS6' Removable 
CD-ROM
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

I take that it is attempting to scan all 8 addresses of the scsi bus 
even though its actually hitting the atapi stuff?  Or do I need an 
even fresher version of cdrecord? or libscg?

>please cc me, I'm not subscribed
>
>Greetings
>Thomas

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

