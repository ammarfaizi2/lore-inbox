Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTJWTr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTJWTr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 15:47:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24797 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261733AbTJWTr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 15:47:56 -0400
Date: Thu, 23 Oct 2003 21:47:49 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: David Brownell <dbrownell@users.sourceforge.net>,
       Dave Hollis <dhollis@davehollis.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.4.23-pre8: usbnet.c doesn't compile with gcc 2.95
Message-ID: <20031023194748.GH11807@fs.tum.de>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile error in 2.4.23-pre8 with gcc 2.95:

<--  snip  -->

...
gcc-2.95 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre8-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6   
-nostdinc -iwithprefix include -DKBUILD_BASENAME=usbnet  -c -o usbnet.o 
usbnet.c
usbnet.c:161: warning: `CONFIG_USB_AX8817X' redefined
/home/bunk/linux/kernel-2.4/linux-2.4.23-pre8-full/include/linux/autoconf.h:2074: 
warning: this is the location of the previous definition
usbnet.c: In function `ax8817x_write_cmd_async':
usbnet.c:496: parse error before `;'
usbnet.c:501: parse error before `;'
make[3]: *** [usbnet.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.23-pre8-full/drivers/usb'

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

