Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVCIE0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVCIE0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 23:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVCIE0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 23:26:35 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:44206 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261495AbVCIE0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 23:26:30 -0500
Date: Tue, 08 Mar 2005 23:26:28 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: 2.6.11-mm2 vs audio for kino and tvtime
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503082326.28737.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Andrew;

2.6.11-mm2 seems to work, mostly.

First, the ieee1394 stuff seems to have fixed up that driver, and kino 
can access my movie cameras video over the firewire very nicely 
without applying the bk-ieee1394-patch.  The camera has builtin 
stereo mics in it, but nary a peep can be heard from it thru the 
firewire.  Am I supposed to be able to hear that?

Second, I have a pdHDTV-3000 card, and up till now I've been 
overwriting the bttv stuffs with the drivers in pcHDTV-1.6.tar.gz by 
doing a make clean;make;make install.  But now thats broken, and the 
error message doesn't seem to make sense to this old K&R C guy.

The error exit:
make[1]: Entering directory `/usr/src/linux-2.6.11-mm2'
  CC 
[M]  /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.o
/usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:362: 
error: unknown field `id' specified in initializer
/usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:362: 
warning: missing braces around initializer
/usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:362: 
warning: (near initialization for 
`bttv_i2c_client_template.released')
make[2]: *** 
[/usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.o] 
Error 1
make[1]: *** 
[_module_/usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver] Error 
2
make[1]: Leaving directory `/usr/src/linux-2.6.11-mm2'
make: *** [modules] Error 2

The braces are indeed there.

Third, somewhere between 2.6.11-rc5-RT-V0.39-02 and 2.6.11, I've lost 
my sensors except for one on the motherboard called THRM by 
gkrellm-2.28.  Nothing seems to be able to bring the w83627hf back to 
life.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
