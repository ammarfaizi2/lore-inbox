Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270468AbTGZR1L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270470AbTGZR1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:27:11 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:18831 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP id S270468AbTGZR1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:27:05 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>,
       linux-kernel@vger.kernel.org
Subject: Re: make menuconfig and 2.4.22-pre8
Date: Sat, 26 Jul 2003 13:42:16 -0400
User-Agent: KMail/1.5.1
References: <20030726171527.GA1173@finnendahl.de>
In-Reply-To: <20030726171527.GA1173@finnendahl.de>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307261342.17010.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [151.205.10.84] at Sat, 26 Jul 2003 12:42:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 13:15, Orm Finnendahl wrote:
>Hi,
>
>I can't make menuconfig with a 2.4.22-pre8 Kernel.
>
>This is what I did:
>
>grisey:/usr/src# tar -xjf ~orm/install/linux-2.4.21.tar.bz2
>grisey:/usr/src# rm -f linux

you are out of order with the above 2 lines.  Remove the link first, 
then unpack and rename the new kernel.

>grisey:/usr/src# ln -s linux-2.4.21 linux
>grisey:/usr/src# patch -p0 < patch-2.4.22-pre8 2>&1 \
>
>> patch-2.4.22-pre8.log
>
>grisey:/usr/src# cd linux
>grisey:/usr/src/linux# make menuconfig
>rm -f include/asm
>( cd include ; ln -sf asm-i386 asm)
>make -C scripts/lxdialog all
>make[1]: Entering directory `/usr/src/linux-2.4.21/scripts/lxdialog'
>make[1]: Leaving directory `/usr/src/linux-2.4.21/scripts/lxdialog'
>/bin/sh scripts/Menuconfig arch/i386/config.in
>Using defaults found in .config
>Preparing scripts: functions, parsing
>
><...>
>
>(about 3 minutes of awk and kswapd constantly swapping, making the
>whole system extremely unresponsive)
>
>and then:
>
>Beendet
>Awk died with error code 143. Giving up.
>make: *** [menuconfig] Fehler 1
>grisey:/usr/src/linux#
>
>
>With the vanilla kernel 2.4.21 there are no problems at all.
>
>Anybody interested in the patch log?
>
>--
>Orm
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

