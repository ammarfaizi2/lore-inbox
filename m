Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTFZS4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTFZS4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 14:56:01 -0400
Received: from [203.185.132.124] ([203.185.132.124]:64457 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262368AbTFZSzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 14:55:55 -0400
Message-ID: <3EFB4507.30302@thai.com>
Date: Fri, 27 Jun 2003 02:09:59 +0700
From: Samphan Raruenrom <samphan@thai.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
CC: Samphan Raruenrom <samphan@thai.com>
Subject: Re: Crusoe's performance on linux?
References: <3EF1E6CD.4040800@thai.com> <3EF2144D.5060902@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com> <200306240051.RAA12097@cesium.transmeta.com>
In-Reply-To: <200306240051.RAA12097@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> Vojtech Pavlik wrote:
 >> > Could you a test just for me? Take vanilla 2.4.21 and then
 >> > make oldconfig; make dep; time make bzImage
 >> > That's basically what I want to know how long will take, since
 >> > it's one of the most common time consuming tasks the thing will
 >> > have to handle.
 > Done! Here're the results:-
 >> Desktop - Pentium III 1 G Hz 754 MB	->	10.x min.
 >> Tablet PC - Crusoe TM5800 1 GHz 731 MB	->	17.x min.
 >>  From freshdiagnos benchmack, the TPC has about 2x faster RAM.
 >> I use tmpfs for the whole process so disk speed didn't count.
 >> Both test run without X or any foreground process using
 >> 2.4.21-ac1 and RedHat kernel.
 >For what it's worth, we have been completely unable to reproduce these
 >kinds of results at Transmeta; our results are in fact very consistent
 >with the numbers reported by some people for the Sharp MM-10 "Kitty"
 >which is also a 1 GHz TM5800; all of them have been in the 10 minute
 >ballpark.

:-( I'm sorry. It's really my false. So all the time everyone think
that I do exactly as Vojtech told.
For uncomprehensible reason, no, I took the chance to upgrade my kernel
to 2.4.21-ac2 then I 'make menuconfig' instead of 'make ldconfig' so
I have tc1000 specific kernel with e100, VIA EIDE/sound, usb, irda,
bluetooth even ppp and netfilters so it really take 17 min to 'make
modules bzImage' on tc1000 on tmpfs with DMA on. Sorry for making this
confusion :~~ I've just try following exactly what Vojtech told and yes,
it takes about 9.5 min. I'm happy now :-)

But anyway, I use exactly the same source, the same .config (with crusoe
setting) and build it the same way on my Pentium III, tmpfs with DMA on.
So that 10 min vs. 17 min should still mean something, right?
My comparison seem to be interesting (at least to me) because Crusoe
is usually said to be comparable to Pentium III. I happend to have
the desktop machine with equal ram so the comparison should be fair.
as long as the benchmark doesn't use harddisk.
You don't need me for this comparison though. Try to find a
1 GHz Pentium III and run that 2.4.21 kernel build benchmark.
I guess it should take 5.5-5.7 min (if it scale that easy).

Hope these didn't make you too busy. Tell me if you need a hand.
I do love to help.


Samphan Raruenrom,
The Open Source Project,
National Electronics and Computer Technology Center,
Thailand.

