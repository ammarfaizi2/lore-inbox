Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUBDHiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 02:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUBDHiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 02:38:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46845 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266254AbUBDHiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 02:38:17 -0500
Date: Wed, 4 Feb 2004 08:38:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel <linux-kernel@vger.kernel.org>, kkeil@suse.de
Cc: isdn4linux@listserv.isdn4linux.de
Subject: 2.6.2-rc3 with isdn patch + devfs doesn't compile
Message-ID: <20040204073812.GR4443@fs.tum.de>
References: <401E4A80.4050907@web.de> <20040202195139.GB2534@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202195139.GB2534@pingi3.kke.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 08:51:39PM +0100, Karsten Keil wrote:
> On Mon, Feb 02, 2004 at 02:02:56PM +0100, Todor Todorov wrote:
> > Hello everyone,
> > 
> > didn't find any more applicabale mailing list, so here it goes:
> > 
> 
> try the actual I4L for 2.6 patch in 
> ftp://ftp.isdn4linux.de/pub/isdn4linux/kernel/v2.6

FYI:
I'm getting the following compile error in 2.6.2-rc3 with this patch 
applied and CONFIG_DEVFS_FS=n:

<--  snip  -->

...
  CC      drivers/isdn/capi/capidrv.o
In file included from drivers/isdn/capi/capidrv.c:25:
include/linux/isdn.h:637: error: parse error before "devfs_handle_t"
include/linux/isdn.h:637: warning: no semicolon at end of struct or union
include/linux/isdn.h:638: warning: type defaults to `int' in declaration 
of `devfs_handle_isdnctrl'
include/linux/isdn.h:638: warning: data definition has no type or storage class
include/linux/isdn.h:639: error: parse error before "devfs_handle_isdnX"
include/linux/isdn.h:639: warning: type defaults to `int' in declaration of `devfs_handle_isdnX'
include/linux/isdn.h:639: warning: data definition has no type or storage class
include/linux/isdn.h:640: error: parse error before "devfs_handle_isdnctrlX"
include/linux/isdn.h:640: warning: type defaults to `int' in declaration of `devfs_handle_isdnctrlX'
include/linux/isdn.h:640: warning: data definition has no type or storage class
include/linux/isdn.h:642: error: parse error before "devfs_handle_ipppX"
include/linux/isdn.h:642: warning: type defaults to `int' in declaration of `devfs_handle_ipppX'
include/linux/isdn.h:642: warning: data definition has no type or storage class
include/linux/isdn.h:645: error: parse error before '}' token
include/linux/isdn.h:645: warning: type defaults to `int' in declaration of `isdn_dev'
include/linux/isdn.h:645: warning: data definition has no type or storage class
include/linux/isdn.h:647: error: parse error before '*' token
include/linux/isdn.h:647: warning: type defaults to `int' in declaration of `dev'
include/linux/isdn.h:647: warning: data definition has no type or storage class
drivers/isdn/capi/capidrv.c:2111:10: warning: #warning FIXME: maybe a 
race condition the card should be removed here from global list /kkeil
make[3]: *** [drivers/isdn/capi/capidrv.o] Error 1

<--  snip  -->

> Karsten Keil

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

