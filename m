Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262834AbTCQIMZ>; Mon, 17 Mar 2003 03:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262837AbTCQIMZ>; Mon, 17 Mar 2003 03:12:25 -0500
Received: from imo-r01.mx.aol.com ([152.163.225.97]:42211 "EHLO
	imo-r01.mx.aol.com") by vger.kernel.org with ESMTP
	id <S262834AbTCQIMY>; Mon, 17 Mar 2003 03:12:24 -0500
Message-ID: <3E758570.5090003@netscape.net>
Date: Mon, 17 Mar 2003 00:21:04 -0800
From: Sheng Long Gradilla <skamoelf@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Toplica Tanaskovic <toptan@EUnet.yu>
CC: linux-kernel@vger.kernel.org
Subject: Re: AGP 3.0 for 2.4.21-pre5
References: <200303151816.39915.toptan@EUnet.yu> <3E74AC3B.6070404@netscape.net> <200303170008.41525.toptan@EUnet.yu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did. If I patch the kernel, my compiling procedure is always as follows:

==================
make clean
make mrproper
make menuconfig
make dep
make modules
make bzlilo
make modules_install
shutdown -r now
==================

The module loads fine. In /var/log/messages there are reports of
detecting AGP 3.5 compatible hardware, but as I said, X just won't start
properly and will report AGP 4X mode.

I checked /proc/driver/nvidia, and it reports AGP 8X hardware and
everything.

I was thinking, I have not tested the nvidia kernel module with the 2.5
kernel. There is an unofficial patch for getting it to compile. I might
give it a try to see if it works, but that won't happen soon.

If anyone wants to give it a try, visit:

http://www.minion.de/nvidia.html





Toplica Tanaskovic wrote:
 > Dana nedelja 16. mart 2003. 17:54 napisali ste:
 >
 >>I tested it with my NVidia GeForce 4 Ti4200 with AGP8X. No luck for me
 >>yet. X is still reporting AGP 4X in the log, I get garbage on the screen
 >>and my PC locks up.
 >>
 >>I am not sure if this has something to do with the NVidia driver for X,
 >>or just a bug in your module/backport.
 >>
 >
 >     You have to run make clean first, or faster way go to 
drivers/char/agp/ and
 > delete any .o files, and then do make modules...
 >
 >     I'll have to figure out way to force compilation of agpgart if 
only agp 3.0
 > menu item was changed.



