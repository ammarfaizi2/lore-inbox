Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVEFUTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEFUTW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 16:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVEFUTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 16:19:22 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:32351 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261157AbVEFUTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 16:19:18 -0400
Message-ID: <427BD143.4010909@tls.msk.ru>
Date: Sat, 07 May 2005 00:19:15 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 3c509 module and 2.6 kernel: not all NICs are recognized?
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, I tried to boot our gateway machine into 2.6 (2.6.11.8
to be certain) kernel.  The machine is quite old, it's 100MHz
Pentium-classic, yet it works as a router just fine.

And surprizingly, this is the first machine I tried to upgrade
to 2.6 which does not work.

It have 4 3c509 cards, one EISA and 3 ISA.  Here's the dmesg
output when I load 3c509 module on 2.4 kernel:

eth0: 3c5x9 at 0x2000, 10baseT port, address  00 60 08 4b 31 bf, IRQ 15.
3c509.c:1.19 16Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
eth1: 3c5x9 at 0x3000, 10baseT port, address  00 20 af 92 f6 ef, IRQ 7.
3c509.c:1.19 16Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
eth2: 3c5x9 at 0x4000, 10baseT port, address  00 20 af 92 83 02, IRQ 5.
3c509.c:1.19 16Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
eth3: 3c5x9 at 0x5000, BNC port, address  00 20 af 99 f2 ac, IRQ 12.
3c509.c:1.19 16Oct2002 becker@scyld.com
http://www.scyld.com/network/3c509.html

(the last one, with IRQ#12 and BNC port, is EISA).

But when in 2.6, only this last EISA one is recognized by
3c509 module.

Any ideas?

Thanks.

/mjt
