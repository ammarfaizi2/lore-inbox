Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277385AbRJZDYm>; Thu, 25 Oct 2001 23:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277393AbRJZDYd>; Thu, 25 Oct 2001 23:24:33 -0400
Received: from mail1.amc.com.au ([203.15.175.2]:14597 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S277385AbRJZDYS>;
	Thu, 25 Oct 2001 23:24:18 -0400
Message-Id: <5.1.0.14.0.20011026125325.024517e0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 26 Oct 2001 13:24:48 +1000
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS/Trident 4DWave sound driver oops
Cc: "Michael F. Robbins" <compumike@compumike.com>,
        Robert Love <rml@tech9.net>,
        Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1004064125.19937.5.camel@phantasy>
In-Reply-To: <g087jff1.wl@nisaaru.dvs.cs.fujitsu.co.jp>
 <1004016263.1384.15.camel@tbird.robbins>
 <7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
 <1004060759.11258.12.camel@phantasy>
 <6693w4ds.wl@nisaaru.dvs.cs.fujitsu.co.jp>
 <1004061741.11366.32.camel@phantasy>
 <g087jff1.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:42 PM 25/10/01 -0400, Robert Love wrote:
>On Thu, 2001-10-25 at 22:36, Tachino Nobuhiro wrote:
> >   No. {0, } is the last elemnet of ac97_codec_ids[] and that index is
> > ARRAY_SIZE(ac97_code_ids) - 1. So this element which should be used as
> > a loop terminator is used as a valid entry in for loop incorrectly.
> >
> > Please read ac97_codec.c
>
>You are right; I apologize.

Implemented the patch suggested, and the module no longer oops's, and I get 
codec id's listed as 0x0000:0x0000 (Unknown). I still get no sound like I 
did with 2.4.7 (using mpg123 as a test, with a known working mp3 file), and 
output to the device is blocked (nothing gets written).

How can I find out the ac97 codec ID for this chipset (if there is one) so 
it can be added to the ac97_codec_ids array? From what I can tell, it's as 
though the codec->codec_read(codec, AC97_VENDOR_ID#) isn't returning the 
codec value for this system at all.

Any suggestions?


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

