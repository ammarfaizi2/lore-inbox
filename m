Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVCIGq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVCIGq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVCIGqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:46:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261775AbVCIGp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:45:26 -0500
Date: Tue, 8 Mar 2005 22:44:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       video4linux-list@redhat.com, sensors@Stimpy.netroedge.com
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime
Message-Id: <20050308224441.2e29f895.akpm@osdl.org>
In-Reply-To: <200503082326.28737.gene.heskett@verizon.net>
References: <200503082326.28737.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> Greetings Andrew;

g'day.

> 2.6.11-mm2 seems to work, mostly.
> 
> First, the ieee1394 stuff seems to have fixed up that driver, and kino 
> can access my movie cameras video over the firewire very nicely 
> without applying the bk-ieee1394-patch.  The camera has builtin 
> stereo mics in it, but nary a peep can be heard from it thru the 
> firewire.  Am I supposed to be able to hear that?

Was it working with 2.6.11+bk-ieee1394.patch?  Or with anything else?

Cc'ed linux1394-devel@lists.sourceforge.net

> Second, I have a pdHDTV-3000 card, and up till now I've been 
> overwriting the bttv stuffs with the drivers in pcHDTV-1.6.tar.gz by 
> doing a make clean;make;make install.  But now thats broken, and the 
> error message doesn't seem to make sense to this old K&R C guy.
>
> The error exit:
> make[1]: Entering directory `/usr/src/linux-2.6.11-mm2'
>   CC 
> [M]  /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.o
> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:362: 
> error: unknown field `id' specified in initializer
> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:362: 
> warning: missing braces around initializer
> /usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.c:362: 
> warning: (near initialization for 
> `bttv_i2c_client_template.released')
> make[2]: *** 
> [/usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver/bttv-i2c.o] 
> Error 1
> make[1]: *** 
> [_module_/usr/pcHDTV3000/linux/pcHDTV-1.6/kernel-2.6.x/driver] Error 
> 2
> make[1]: Leaving directory `/usr/src/linux-2.6.11-mm2'
> make: *** [modules] Error 2
> 
> The braces are indeed there.

What's pcHDTV-1.6.tar.gz?  If it was merged up then these things wouldn't
happen.

CC'ed video4linux-list@redhat.com

> Third, somewhere between 2.6.11-rc5-RT-V0.39-02 and 2.6.11, I've lost 
> my sensors except for one on the motherboard called THRM by 
> gkrellm-2.28.  Nothing seems to be able to bring the w83627hf back to 
> life.

CC'ed sensors@Stimpy.netroedge.com
