Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUDEVsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUDEVpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:45:09 -0400
Received: from host213-123-250-229.in-addr.btopenworld.com ([213.123.250.229]:40
	"EHLO 2003SERVER.sbs2003.local") by vger.kernel.org with ESMTP
	id S263301AbUDEVnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:43:13 -0400
thread-index: AcQbV0/d3vDTw1P8SESdhxUcIVchXg==
X-Sieve: Server Sieve 2.2
Date: Mon, 5 Apr 2004 22:45:28 +0100
From: "Christian Kujau" <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
Message-ID: <000001c41b57$4feddd70$d100000a@sbs2003.local>
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <Administrator@vger.kernel.org>
Cc: "Sven Hartge" <hartge@ds9.gnuu.de>, <linux-kernel@vger.kernel.org>,
       "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
References: <20040329151515.GD2895@smtp.west.cox.net> <Pine.GSO.4.44.0403301430180.12030-100000@math.ut.ee> <E1B8OEW-0006Jb-BX@ds9.argh.org> <40704743.3000909@g-house.de> <20040405155022.GL31152@smtp.west.cox.net>
X-Mailer: Microsoft CDO for Exchange 2000
In-Reply-To: <20040405155022.GL31152@smtp.west.cox.net>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
Content-Class: urn:content-classes:message
Importance: normal
Envelope-to: paul@sumlocktest.fsnet.co.uk
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-OriginalArrivalTime: 05 Apr 2004 21:45:29.0125 (UTC) FILETIME=[4FFC3550:01C41B57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[ if someone is bored from me cc'ing too many - plz cry! ]

Tom Rini wrote:
| OK, hmm.  I've got some better ideas then.  It sounds like the code to
| have puts show up on VGA isn't selected/compiled in.  Or, there's still
| some other problem wrt the OF transition code.  Just having a serial
| console selected still doesn't give output however, right?

I'll give it a try with 2.6 this week.

|
|>another issue here: i was finally able to cross-compile 2.5.x / 2.6.x
|>kernels (on x86). i tried to compile kernels from 2.5.21 on with
|>"allnoconfig" (was introduced in 2.5.21). only 2.5.30 can be built, all
|>other attempts to build "zImage" fail...(still compiling 2.5.6x)...
|>(full logs of builds available...)
|
| The simple answer is, don't use allnoconfig :).  Do a 'make
| common_defconfig' and then from there turn off stuff you don't need.

um, yes. but the target "common_defconfig" was disabled somewhere in
2.5, so my shini script broke. i wanted to do common_defconfig first,
then always keep my .config and do "oldconfig" after patching, but
somehow my script broke, so i went with "allnoconfig"...but ok, i'll try
again.

if anyone is interested: http://nerdbynature.de/bits/sheep/build/
all the logfiles produced when patchin/compiling 2.5.21 up to 2.5.75.


right here the latest 2.4-benh and 2.6-benh kernels (via rsync), also
compiled via crosscompile: http://nerdbynature.de/bits/sheep/latest-kernel/

thanks,
Christian.
- --
BOFH excuse #212:

Of course it doesn't work. We've performed a software upgrade.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


