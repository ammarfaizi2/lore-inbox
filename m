Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbUAJEGf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 23:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUAJEGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 23:06:35 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:37585 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S264565AbUAJEG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 23:06:26 -0500
Subject: Re: i2c_adapter i2c-0: Bus collision!
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
In-Reply-To: <20040108230559.05a5674c.khali@linux-fr.org>
References: <1073527236.624.7.camel@buick>
	 <20040108230559.05a5674c.khali@linux-fr.org>
Content-Type: multipart/mixed; boundary="=-xrZGmktWKvFnUazB2Duz"
Message-Id: <1073707567.621.5.camel@buick>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 05:06:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xrZGmktWKvFnUazB2Duz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

tor, 08.01.2004 kl. 23.05 skrev Jean Delvare: 
> > i2c_adapter i2c-0: Bus collision! SMBus may be locked until next hard
> > reset. (sorry!)
> > 
> > Kernel 2.6.0 with lm-sensors 2.8.2.
> 
> Are you able to reproduce the same behavior with kernel 2.4.24 and
> lm-sensors 2.8.2?

Just tried, and I do. I forgot to mention it in my last mail, but I
sometime has to reload the modules before "sensors" finds any sensor.

> > I get very weird results, especially on the fan, but others as well.
> > Here are three runs of sensors:
> > (...)
> 
> Could you provide a few outputs of "i2cdump 0 0x2d"? I wonder if this
> will show read errors (as "XX") or simply changing values.

Attached three runs. Seems to be some read errors :( On these three runs I got
first three bus-collisions, then one, and last two.

> Does your BIOS provide a feature such as "Circle Of Protection" or
> anything that sounds like "active" hardware monitoring? Is it enabled?

No such option.

> If you have any other chips (eeproms for example) on the bus, do you
> observe similar behavior with these?

Not other chips.

> > It works fine with MBM in Windows. Well, MBM is having some troubles
> > with the temperature (it gets lower and lower as time pass, and ends
> > on about 8-9 degrees celsius. But fan and temperatures are read just
> > fine, never any glitch. On thing thing though, the Vcore2 is 1,70. The
> > Bios reports it correctly, but both MBM and LM-sensors says 1,50. Have
> > no idea why. The 1,50 is static, never changes, while VCore1 (which
> > ideally should be 1,75) varies from 1,75 to 1,79. In the BIOS both
> > seem sane, and varies with 3-4 degrees.
> > 
> > I guess all these problems are because of the bus collision, which I
> > have read usually happens because of bad boards. Which I admit that I
> > do have, but it works in Windows :(
> 
> Which motherboard is it?

A Rioworks SDVIA (http://www.rioworks.com/SDVIA.htm) Not very new, I'm afraid.
And not very good.

> Did you have to enable any particular option in MBM?

Nah, it just worked :)

> > What are the most common reasons for the bus collisions (...)?
> 
> Bad brakes?
> 
> Just kidding... ;)

Hehe :)

I guess this is unsolvable, but I just wanted to hear what you say. Kinda weird
it works so well with MBM, but that's ok. It's just for fun I want it to work.

Thanks for your reply :)

Best regards,
Stian

--=-xrZGmktWKvFnUazB2Duz
Content-Disposition: attachment; filename=i2cdump.txt
Content-Type: text/plain; name=i2cdump.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: 71 XX d1 bb bb 79 6e 7f d9 d4 ff ff 00 ff 00 ed    qX???yn???.....?
30: b0 df ff fd be bf ff ff b9 XX ff 6f 77 ef XX 00    ??.???..?X.ow?X.
40: 01 00 10 00 00 00 00 56 XX 03 01 40 41 85 80 5c    ?.?....VX??@A??\
50: ff ff 00 ff ff ff 00 00 30 70 ff ff 19 0f ff ff    ........0p..??..
60: XX 5e d1 bb bb 77 6e 7f dd d7 ff ff XX ff 00 ed    X^???wn???..X..?
70: b0 df ff fd be bf ff ff b9 fd ff 6f 77 ef 00 00    ??.???..??.ow?..
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 70 5e d1 bb bb 77 6c 7f dd d4 ff 00 00 ff 00 ed    p^???wl???.....?
b0: XX df ff fd be bf ff ff b9 fd ff 6f 77 ef 00 00    X?.???..??.ow?..
c0: 01 00 10 00 00 00 00 56 2d 03 01 40 41 85 80 5c    ?.?....V-??@A??\
d0: ff ff 00 ff ff ff 00 XX 30 70 ff ff 19 0f ff ff    .......X0p..??..
e0: 71 5e d1 b9 bb 78 6e XX XX d8 ff ff 00 ff XX ed    q^???xnXX?....X?
f0: b0 df ff fd be bf ff ff b9 fd ff 6f 77 XX 00 00    ??.???..??.owX..

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: 71 XX d1 bb bb 79 6e 7f dd d9 ff ff 00 ff 00 db    qX???yn???.....?
30: b0 df ff fd be bf ff ff b9 fd ff 6f 77 ef 00 00    ??.???..??.ow?..
40: 01 00 10 00 00 00 00 56 2c 03 01 40 41 85 XX 5c    ?.?....V,??@A?X\
50: ff ff 00 ff ff ff 00 00 30 70 ff ff 19 0f ff ff    ........0p..??..
60: 70 5e d1 bb bb 7b 6c 7f dd d9 ff ff 00 ff 00 ed    p^???{l???.....?
70: b0 df ff fd be XX ff ff b9 fd ff 6f 77 ef 00 00    ??.??X..??.ow?..
80: ff ff ff ff ff ff ff ff ff ff ff XX ff ff ff ff    ...........X....
90: ff ff ff ff ff ff ff ff ff ff ff ff XX ff ff ff    ............X...
a0: 72 5e d1 bb bb 7a 6e 7f d9 d8 ff ff 00 ff 00 ec    r^???zn???.....?
b0: b0 df ff fd be bf ff XX b9 fd ff 6f 77 ef 00 00    ??.???.X??.ow?..
c0: 01 00 10 00 00 00 00 56 2d XX 01 40 41 85 80 5c    ?.?....V-X?@A??\
d0: ff ff 00 ff ff ff 00 00 30 70 ff ff 19 0f ff ff    ........0p..??..
e0: 70 5e d1 bb bb 78 6c 7f d9 d5 ff ff 00 XX 00 ed    p^???xl???...X.?
f0: b0 df ff fd bd bf ff ff b9 fd ff 6f 77 ef 00 00    ??.???..??.ow?..

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff XX XX XX ff ff ff ff ff ff ff    ......XXX.......
10: ff ff ff ff ff XX XX ff ff ff ff XX ff ff ff ff    .....XX....X....
20: 70 XX d1 ba bc 78 6e 7f de d8 ff ff 00 ff 00 ed    pX???xn???.....?
30: b0 df ff fd be bf ff ff b9 fd ff 6f 77 ef 00 00    ??.???..??.ow?..
40: 01 00 10 00 00 00 00 56 2d 03 01 40 41 85 80 5c    ?.?....V-??@A??\
50: ff ff 00 ff ff ff 00 00 30 70 ff ff 19 0f ff ff    ........0p..??..
60: 70 5e d1 bb bb 78 6d 7f de d7 ff ff 00 ff 00 ed    p^???xm???.....?
70: b0 df ff fd be bf ff ff b9 fd ff 6f 77 ef 00 00    ??.???..??.ow?..
80: ff ff ff ff ff ff XX XX ff ff ff ff ff ff ff ff    ......XX........
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 71 XX d1 bb bb 78 6d 7f XX d8 ff ff 00 ff 00 ed    qX???xm?X?.....?
b0: b0 df ff fd be bf ff ff b9 fd ff 6f 77 ef 00 00    ??.???..??.ow?..
c0: 01 00 10 00 00 00 00 56 2d 03 01 40 41 84 80 5c    ?.?....V-??@A??\
d0: ff ff 00 ff ff ff 00 00 30 70 ff ff 19 0f ff ff    ........0p..??..
e0: 73 5d d1 bb bb 7a XX 7f de d8 ff ff 00 ff 00 ed    s]???zX???.....?
f0: b0 df ff fd be bf ff ff b9 fd ff 6f 77 ef 00 00    ??.???..??.ow?..

--=-xrZGmktWKvFnUazB2Duz--

