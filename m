Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWEBSAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWEBSAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWEBSAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:00:46 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:25034 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP id S964950AbWEBSAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:00:45 -0400
From: Michael Helmling <supermihi@web.de>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: New, yet unsupported USB-Ethernet adaptor
Date: Tue, 2 May 2006 20:02:15 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022002.15845.supermihi@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I bought an USB-Ethernet adaptor from delock (www.delock.de) and found it was 
not supported by linux from the vendor. So I played a little with lsusb and 
found it uses a MCS7830 chip from MosChip semiconductor (moschip.com). On 
their homepage I found a driver but it only was a precompiled Fedora4 module. 
So I wrote them an email and they sent me the whole source code for the 
module . Unfortunately it doesn't compile on my machine with a 2.6.16 kernel, 
but in does on a friend's one who uses 2.6.12, so I assume something has 
changed in the kernel interface (I get errors with sk_buff_head not 
containing "list").
I have no idea of how to correct this but maybe someone else can. I attached
the sourcecode wich is licensed under the GPL.
Would be nice to see this supported in further kernel releases.
The sourcecode can be found at ftp://supermihi.myftp.org
The output I get when running make is attached below.

Regards,
Michael

PS: I first posted this in usenet comp.os.linux.hardware and was redirected to 
send it to linux-usb-devel and lkml. Please tell me when I'm wrong.

Output of make:

michael@michi-pc ~/mcs7830FC4Ver1.0.0.1 $ LC_ALL="POSIX" make
make -C /lib/modules/2.6.16-gentoo-r1/build 
SUBDIRS=/home/michael/mcs7830FC4Ver1.0.0.1 modules;
make[1]: Entering directory `/usr/src/linux-2.6.16-gentoo-r1'
  CC [M]  /home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.o
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `init_status':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:383: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:383: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:383: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:383: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:383: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `skb_return':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:401: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:401: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:401: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:406: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:406: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `ANGInitializeDev':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:901: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:985: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:998: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1027: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `mdio_read':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1046: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1039: warning: unused variable 
`val'
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1039: warning: unused variable 
`val2'
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1041: warning: unused variable 
`ReadHifVal'
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `mdio_write':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1191: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1191: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `defer_bh':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1314: error: structure has no 
member named `list'
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `defer_kevent':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1336: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1336: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1338: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1338: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `rx_submit':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1358: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1373: error: `URB_ASYNC_UNLINK' 
undeclared (first use in this function)
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1373: error: (Each undeclared 
identifier is reported only once
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1373: error: for each function it 
appears in.)
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1389: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1394: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1394: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1402: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `rx_process':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1427: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `rx_complete':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1455: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1455: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1472: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1472: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1485: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1485: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1502: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1502: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1517: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `intr_complete':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1535: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1535: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1542: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1542: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1552: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1552: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `unlink_urbs':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1579: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1579: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_stop':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1603: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1603: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1603: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1603: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1603: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1619: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1619: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_open':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1653: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1653: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1653: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1653: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1653: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1664: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1664: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1673: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1673: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1684: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1684: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1684: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1684: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1684: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function 
`usbnet_set_rx_mode':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1703: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1703: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1711: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1719: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1727: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1734: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1739: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1752: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `kevent':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1833: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1833: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1845: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1845: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1874: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1874: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1874: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1874: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1874: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1882: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1882: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `tx_complete':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1923: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1923: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1931: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1931: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_start_xmit':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1975: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1983: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2000: error: `URB_ASYNC_UNLINK' 
undeclared (first use in this function)
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2024: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2024: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2042: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2057: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2057: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2065: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2065: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2065: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_bh':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2095: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2095: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2124: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2124: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2124: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_disconnect':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2158: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2158: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2158: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2158: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_probe':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2194: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2194: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2194: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2207: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2234: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: left-hand operand 
of comma expression has no effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: At top level:
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2407: error: unknown field 
`owner' specified in initializer
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2407: warning: initialization 
from incompatible pointer type
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `mdio_read':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1046: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1055: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1063: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1074: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1082: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1102: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1107: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function 
`mcs7830_disconnect':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1269: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `mdio_write':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1191: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1192: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1196: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1208: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1218: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1230: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1239: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `defer_kevent':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1336: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1338: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `rx_submit':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1358: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1389: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1394: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1402: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `rx_complete':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1455: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1472: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1485: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1502: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1517: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `intr_complete':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1535: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1542: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1552: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `unlink_urbs':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1579: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_stop':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1598: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1599: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1603: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1619: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1633: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_open':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1649: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1653: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1664: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1673: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1684: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1693: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `kevent':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1833: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1845: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1874: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1882: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `tx_complete':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1923: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1926: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1931: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_start_xmit':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1975: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1983: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2018: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2024: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2031: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2042: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2050: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2057: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2065: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_bh':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2095: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2124: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_disconnect':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2158: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: In function `usbnet_probe':
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2194: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2207: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2220: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2222: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2226: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2231: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2234: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:2321: warning: statement with no 
effect
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c: At top level:
/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.c:1699: warning: 
'usbnet_set_rx_mode' defined but not used
make[2]: *** [/home/michael/mcs7830FC4Ver1.0.0.1/mcs7830.o] Error 1
make[1]: *** [_module_/home/michael/mcs7830FC4Ver1.0.0.1] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.16-gentoo-r1'
make: *** [default] Error 2
