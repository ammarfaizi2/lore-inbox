Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbTCNRnW>; Fri, 14 Mar 2003 12:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263436AbTCNRnW>; Fri, 14 Mar 2003 12:43:22 -0500
Received: from port-212-202-184-40.reverse.qdsl-home.de ([212.202.184.40]:18572
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S263435AbTCNRnV>; Fri, 14 Mar 2003 12:43:21 -0500
Message-ID: <3E7215C5.2040302@trash.net>
Date: Fri, 14 Mar 2003 18:47:49 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030311 Debian/1.2.1-10
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  missing cli() in isdn_net.c
Content-Type: multipart/mixed;
 boundary="------------060201050601090200010809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201050601090200010809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kai,
this patch fixes a missing cli() in isdn_net_setcfg().

Regards,
Patrick

--------------060201050601090200010809
Content-Type: text/plain;
 name="isdn_net-missing-cli.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isdn_net-missing-cli.diff"

diff -urN linux-2.4.20-clean/drivers/isdn/isdn_net.c linux-2.4.20/drivers/isdn/isdn_net.c
--- linux-2.4.20-clean/drivers/isdn/isdn_net.c	2002-11-29 00:53:13.000000000 +0100
+++ linux-2.4.20/drivers/isdn/isdn_net.c	2003-03-14 18:37:05.000000000 +0100
@@ -2831,6 +2831,7 @@
 
 			/* If binding is exclusive, try to grab the channel */
 			save_flags(flags);
+			cli();
 			if ((i = isdn_get_free_channel(ISDN_USAGE_NET,
 				lp->l2_proto, lp->l3_proto, drvidx,
 				chidx, lp->msn)) < 0) {

--------------060201050601090200010809--

