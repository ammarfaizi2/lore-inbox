Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbRDNKiQ>; Sat, 14 Apr 2001 06:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131985AbRDNKiG>; Sat, 14 Apr 2001 06:38:06 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:52237 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131974AbRDNKhz> convert rfc822-to-8bit; Sat, 14 Apr 2001 06:37:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
Date: Sat, 14 Apr 2001 12:45:07 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca> <20010413090751.E4557@greenhydrant.com> <3AD7416A.A6B65A86@bigfoot.com>
In-Reply-To: <3AD7416A.A6B65A86@bigfoot.com>
MIME-Version: 1.0
Message-Id: <01041412085801.00516@debian>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 13. April 2001 20:11 schrieb Tim Moore:

> Try 'hdparm -tT'  with simultaneous /dev/hda3 and /dev/hdc3.  This gives
> you a baseline on the actual partitions involved.

hdparm -tT simultanous on /dev/hda3 and /dev/hdc3:

/dev/hda3:
 Timing buffer-cache reads:   128 MB in  2.29 seconds = 55.90 MB/sec
 Timing buffered disk reads:  64 MB in  4.67 seconds = 13.70 MB/sec

/dev/hdc3:
 Timing buffer-cache reads:   128 MB in  2.28 seconds = 56.14 MB/sec
 Timing buffered disk reads:  64 MB in  4.61 seconds = 13.88 MB/sec

Now on single HD  -  /dev/hda3 :

/dev/hda3:
 Timing buffer-cache reads:   128 MB in  1.30 seconds = 98.46 MB/sec
 Timing buffered disk reads:  64 MB in  2.26 seconds = 28.32 MB/sec

It looks like reading on /dev/hda3 locks /dev/hdc3 ...
Is it necessary to apply  the ide-patches to the kernel ?

Andreas
-- 
Andreas Peter *** ujq7@rz.uni-karlsruhe.de

