Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268698AbUIMPRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268698AbUIMPRB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268401AbUIMPQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:16:14 -0400
Received: from jade.spiritone.com ([216.99.193.136]:11933 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267690AbUIMPJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:09:59 -0400
Date: Mon, 13 Sep 2004 08:09:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, colpatch@us.ibm.com,
       Paul Jackson <pj@sgi.com>, Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <650660000.1095088173@[10.10.2.4]>
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
References: <20040913015003.5406abae.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, starfire broke and qlogicisp. Plus some NUMA stuff in mm/mempolicy.c
Full error log below. Config is (on ia32):

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/config.numaq

The NUMA one is either cpusets-big-numa-cpu-and-memory-placement.patch
or create-nodemask_t.patch by the looks of it. The only thing touching
starfire is bk-netdev.patch, but as I get very similar errors from qlogicisp
maybe someone's been futzing with readw/writew ?

M.

drivers/net/starfire.c: In function `starfire_init_one':
drivers/net/starfire.c:924: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/net/starfire.c:930: warning: passing arg 1 of `readb' makes pointer from integer without a cast
drivers/net/starfire.c:935: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:937: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:940: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:944: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c: In function `mdio_read':
drivers/net/starfire.c:1087: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c: In function `mdio_write':
drivers/net/starfire.c:1100: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c: In function `netdev_open':
drivers/net/starfire.c:1123: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1124: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1162: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1169: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1177: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1179: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1180: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1181: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1182: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1183: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1185: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1189: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1196: warning: passing arg 2 of `writeb' makes pointer from integer without a cast
drivers/net/starfire.c:1199: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1200: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1201: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1205: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1206: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1207: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1213: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1215: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1217: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1219: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1232: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1238: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1240: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1241: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1257: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1260: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c: In function `tx_timeout':
drivers/net/starfire.c:1312: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c: In function `init_ring':
drivers/net/starfire.c:1356: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c: In function `start_tx':
drivers/net/starfire.c:1477: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c: In function `intr_handler':
drivers/net/starfire.c:1505: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1522: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1562: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1593: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c: In function `__netdev_rx':
drivers/net/starfire.c:1710: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c: In function `refill_rx_ring':
drivers/net/starfire.c:1779: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c: In function `netdev_media_change':
drivers/net/starfire.c:1839: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1841: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:1849: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c: In function `netdev_error':
drivers/net/starfire.c:1865: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c: In function `get_stats':
drivers/net/starfire.c:1891: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1892: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1893: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1895: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1895: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1896: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1898: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1898: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1901: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/net/starfire.c:1902: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1903: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1904: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1905: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:1906: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c: In function `set_rx_mode':
drivers/net/starfire.c:1961: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1962: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1963: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1967: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1968: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1969: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1990: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1991: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1992: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1995: warning: passing arg 2 of `writew' makes pointer from integer without a cast
drivers/net/starfire.c:1998: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c: In function `netdev_close':
drivers/net/starfire.c:2099: warning: passing arg 1 of `readl' makes pointer from integer without a cast
drivers/net/starfire.c:2106: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:2109: warning: passing arg 2 of `writel' makes pointer from integer without a cast
drivers/net/starfire.c:2110: warning: passing arg 1 of `readl' makes pointer from integer without a cast
mm/mempolicy.c: In function `get_zonemask':
mm/mempolicy.c:419: `maxnode' undeclared (first use in this function)
mm/mempolicy.c:419: (Each undeclared identifier is reported only once
mm/mempolicy.c:419: for each function it appears in.)
drivers/scsi/qlogicisp.c: In function `isp_inw':
drivers/scsi/qlogicisp.c:632: warning: passing arg 1 of `readw' makes pointer from integer without a cast
drivers/scsi/qlogicisp.c: In function `isp_outw':
drivers/scsi/qlogicisp.c:641: warning: passing arg 2 of `writew' makes pointer from integer without a cast

