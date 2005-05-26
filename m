Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVEZLvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVEZLvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVEZLvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 07:51:09 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:2794 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261323AbVEZLu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 07:50:58 -0400
Date: Thu, 26 May 2005 07:50:57 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: 2.6.12-rc5 build failure
To: linux-kernel@vger.kernel.org
Message-id: <200505260750.57571.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Just now, trying to build 2.6.12-rc5, I'm getting this:
  CC      drivers/char/ipmi/ipmi_devintf.o
drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_new_smi':
drivers/char/ipmi/ipmi_devintf.c:532: warning: passing arg 1 of `class_simple_device_add' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_smi_gone':
drivers/char/ipmi/ipmi_devintf.c:537: warning: passing arg 1 of `class_simple_device_remove' makes integer from pointer without a cast
drivers/char/ipmi/ipmi_devintf.c:537: error: too many arguments to function `class_simple_device_remove'
drivers/char/ipmi/ipmi_devintf.c: In function `init_ipmi_devintf':
drivers/char/ipmi/ipmi_devintf.c:558: warning: assignment from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:566: warning: passing arg 1 of `class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:580: warning: passing arg 1 of `class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function `cleanup_ipmi':
drivers/char/ipmi/ipmi_devintf.c:591: warning: passing arg 1 of `class_simple_destroy' from incompatible pointer type
make[3]: *** [drivers/char/ipmi/ipmi_devintf.o] Error 1
make[2]: *** [drivers/char/ipmi] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

This is new, rc4 is running fairly well.  I thought my .config
had become contaminated, but the IPMI stuff looks ok:

[root@coyote linux-2.6.12-rc5]# grep IPMI .config
# IPMI
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
# CONFIG_IPMI_SI is not set
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set

???

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
