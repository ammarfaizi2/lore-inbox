Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSE2IkT>; Wed, 29 May 2002 04:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSE2IkS>; Wed, 29 May 2002 04:40:18 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:55367 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S314546AbSE2IkR>; Wed, 29 May 2002 04:40:17 -0400
Date: Wed, 29 May 2002 19:25:16 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org
Subject: odd timer bug, similar to VIA 686a symptoms
Message-ID: <Pine.LNX.4.05.10205291912340.2523-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Using Vojtech's arch/i386/kernel/time.c patch ported to 2.2[1], I recently
got the "via686a" bug check triggered after the machine suspended itself
due low battery, including the following lines grepped and snipped out of
kern.log:

May 28 11:19:49 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
May 28 11:19:50 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
May 28 11:19:51 gull kernel: timer.c: VIA bug check triggered. Value read 65499 [0xffdb], re-read 65484 [0xffcc]
May 28 11:19:52 gull kernel: timer.c: VIA bug check triggered. Value read 65498 [0xffda], re-read 65484 [0xffcc]
May 28 11:19:53 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
May 28 11:19:54 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65485 [0xffcd]
May 28 11:19:55 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
May 28 11:19:56 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
May 28 11:19:57 gull kernel: timer.c: VIA bug check triggered. Value read 65499 [0xffdb], re-read 65484 [0xffcc]
May 28 11:19:58 gull kernel: timer.c: VIA bug check triggered. Value read 65497 [0xffd9], re-read 65483 [0xffcb]

Anyone got any good theories what's going on here, given that this is a
~1995 vintage laptop with a Pentium-120 (which I'm assured doesn't have a
VIA 686a ;-)?

Thanks,
Neale.

[1] OK, I stuffed part of the porting of Vojtech's patch (revised version
to come Real Soon Now) but that shouldn't affect the validity of the
greppage from kern.log


