Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbTCRAh2>; Mon, 17 Mar 2003 19:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262035AbTCRAh2>; Mon, 17 Mar 2003 19:37:28 -0500
Received: from [66.186.193.1] ([66.186.193.1]:27660 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S262034AbTCRAh1>; Mon, 17 Mar 2003 19:37:27 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 19:59:06(EST) on March 17, 2003
X-HELO-From: rohan.arnor.net
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: (2.5.65) Unresolved symbols in modules?
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Mar 2003 16:46:57 -0800
Message-Id: <1047948471.12620.9.camel@rohan.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying 2.5 for the first time.  I am getting hundreds of unresolved
symbols in (all?) modules.  Note that:
- I have installed the module-init-tools. 
- "which depmod" as root says /usr/local/sbin/depmod
- depmod -V as root says "module-init-tools 0.9.10"

But make modules_install as root produces:

[lots of mkdir -p /lib/modules/2.5.65/kernel/...; cp drivers/... .ko
/lib/modules/2.5.65/kernel/...]

and then:
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.65; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.65/kernel/drivers/char/lp.ko
depmod:         parport_read
depmod:         parport_set_timeout
depmod:         parport_unregister_device
...
[lots and lots of unresolved symbols in lots of modules]

What am I doing wrong?  What web page or kernel documentation should I
be reading?

Thanks

Torrey Hoffman
thoffman@arnor.net



