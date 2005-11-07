Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVKGEKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVKGEKu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 23:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVKGEKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 23:10:50 -0500
Received: from tornado.reub.net ([202.89.145.182]:8410 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932393AbVKGEKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 23:10:49 -0500
Message-ID: <436ED3C7.8090006@reub.net>
Date: Mon, 07 Nov 2005 17:10:47 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051106)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
References: <20051106182447.5f571a46.akpm@osdl.org>
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/11/2005 3:24 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/
> 
> - Added the 1394 development tree to the -mm lineup, as git-ieee1394.patch
> 
> - Re-added rmk's driver-model tree git-drvmodel.patch
> 
> - Added davem's sparc64 tree, as git-sparc64.patch
> 
> - v4l updates
> 
> - dvb updates

Ok a couple of things so far:

Firstly:

CC [M]  drivers/edac/edac_mc.o
drivers/edac/edac_mc.c: In function 'edac_mc_scrub_block':
drivers/edac/edac_mc.c:647: error: syntax error before 'asm'
drivers/edac/edac_mc.c:647: error: void value not ignored as it ought to be
drivers/edac/edac_mc.c:653: warning: passing argument 1 of 'page_zone' makes 
pointer from integer without a cast
drivers/edac/edac_mc.c:653: error: syntax error before 'do'
drivers/edac/edac_mc.c:653: error: '__dummy' undeclared (first use in this function)
drivers/edac/edac_mc.c:653: error: (Each undeclared identifier is reported only once
drivers/edac/edac_mc.c:653: error: for each function it appears in.)
drivers/edac/edac_mc.c: At top level:
drivers/edac/edac_mc.c:653: error: syntax error before 'while'
make[2]: *** [drivers/edac/edac_mc.o] Error 1
make[1]: *** [drivers/edac] Error 2
make: *** [drivers] Error 2

And secondly:

WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/block/ub.ko needs unknown symbol 
storage_usb_ids
WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/block/ub.ko needs unknown symbol 
usb_usual_clear_present
WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/block/ub.ko needs unknown symbol 
usb_usual_check_type
WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/block/ub.ko needs unknown symbol 
usb_usual_set_present
WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/usb/storage/usb-storage.ko needs 
unknown symbol storage_usb_ids
WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/usb/storage/usb-storage.ko needs 
unknown symbol usb_usual_clear_present
WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/usb/storage/usb-storage.ko needs 
unknown symbol usb_usual_check_type
WARNING: /lib/modules/2.6.14-mm1/kernel/drivers/usb/storage/usb-storage.ko needs 
unknown symbol usb_usual_set_present

It seems that libusual.ko is not being actually built as a module, despite being 
set to 'm' in .config.

Config is up at http://www.reub.net/kernel/

Box is an i386/P4/Intel925 running recent Fedora Rawhide.

Reuben

