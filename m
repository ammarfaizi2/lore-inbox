Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTA1AeC>; Mon, 27 Jan 2003 19:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTA1AeC>; Mon, 27 Jan 2003 19:34:02 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:38536
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S264711AbTA1AeB>; Mon, 27 Jan 2003 19:34:01 -0500
Message-ID: <3E35D228.10905@tupshin.com>
Date: Mon, 27 Jan 2003 16:43:20 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Promise PDC20276 broken in 2.5 and 2.4.21-preX, but not 2.4.20
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There have been two prior reports of a problem with the promise PDC20276 
chipset (on-board piece-o-crap pseudo raid on some KT333 [and others?] 
motherboards). Both of them reported the same problem, i.e. load the 
pdc202xx_new driver and get "neither IDE port enabled (BIOS)" message, 
and therefore an inability to use drives on that controller using either 
the direct ide interface or the pdcraid module. This problem was 
reported on both kernels 2.4.21-pre1 and 2.5.46, and was reported to 
work correctly with 2.4.20 and 2.5.34.

Neither person got a response (at least on the list), so I can't tell if 
anybody is aware of this.

I'm guessing that the 2.5 problem was introduced here 
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/ide/pci/pdc202xx_new.c@1.4

and the corresponding 2.4 backport
http://linux.bkbits.net:8080/linux-2.4/cset@1.757.33.36?nav=index.html|tags|ChangeSet@..1.811

I've run into the same problem with 2.4.21-pre3-ac4, and can also verify 
that it works fine with 2.4.20.

Any takers on why  the 20276 isn't getting initialized correctly 
anymore? Presumably this is not a problem with most of the other promise 
chipsets or it would be much more heavily noticed by now.

-Tupshin



