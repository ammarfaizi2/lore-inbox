Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSGOGXI>; Mon, 15 Jul 2002 02:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317352AbSGOGXH>; Mon, 15 Jul 2002 02:23:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:61076 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317351AbSGOGXG>;
	Mon, 15 Jul 2002 02:23:06 -0400
Message-ID: <009701c22bc8$c8bd54e0$1c6fa8c0@hyper>
From: "Christian Ludwig" <cl81@gmx.net>
To: "Tom Oehser" <tom@toms.net>
Cc: "Daniel Phillips" <phillips@arcor.de>,
       "Ville Herva" <vherva@niksula.hut.fi>,
       "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207121011260.23208-100000@conn6m.toms.net>
Subject: Re: bzip2 support against 2.4.18
Date: Mon, 15 Jul 2002 08:28:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Oehser wrote on Friday, July 12, 2002 4:21 PM:
> I chose the name bz2bzImage and have been using it on tomsrtbt since
2.0.0,
> the reason I chose it was to make as clear as possible that it is still a
> big/compressed image and that the bz2 is additional/different.  I get a
lot
> of confusion from users who assume that bzImage *already* has something to
do
> with bzip2.  I tried to convey that it was a "Bzip2-Big-Compressed-image"
> rather than a "normal" "Big-Compressed-image".  I still prefer it to
either
> bz2Image or bzImage.? or bzip2Image.  But I don't really care.

Fine, I am just working on a new version of the patch, where the make target
'bz2bzImage' disappears. The kernel compression will be a CONFIG option,
too. This is possible, because in the original patch you only changed
'misc.c' to support bzip2. I will release the new version of the patch
within this week (I hope).

The ramdisk compression is already a CONFIG option. You can choose between
gzip/bzip2 ramdisk compression, or you can even select both.

> Note, I have gotten it to work fine with a 4MB machine on 2.2.x, so 2.4.x
> will probably work on 4MB also in some smaller kernel configurations.
Also,
> the speed penalty was not problematic even on 486 machines.  See my post a
> few months ago for details.  But, overall, it is fine on an 8MB 486, and I
> think it is useful enough in embedded and floppy and flash environments
that
> it would be worthwhile.

Kernel 2.4 is much bigger than kernel 2.2. With very small configurations
this should work on 4MB machines as well. You have to try. My kernel was
580kB bzip2 compressed, this one didn't work on 4MB.

> Does your mod of my patch support configuring the normal vs. "small"
option?
> Also, does it support choosing the compression-level-number?  Does it
support
> using gzip/bzip2 one for the kernel and the other for the ramdisk in
either
> combination?  My original patch was only "small", disabled gzip, and I
think
> used "-9" compression for both the kernel and the ramdisk.

Choosing a compression level is (still) not supported, but choosing any
combination of gzip/bzip2 is already implemented. I wonder if it is useful
to have compression-level-numbers? The patch uses '-9' compression in any
case (gzip/bzip2 kernel/ramdisk).

Have fun.

    - Christian


