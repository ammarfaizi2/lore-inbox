Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263155AbTCUAQ7>; Thu, 20 Mar 2003 19:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263337AbTCUAQ7>; Thu, 20 Mar 2003 19:16:59 -0500
Received: from port-212-202-184-28.reverse.qdsl-home.de ([212.202.184.28]:12967
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S263155AbTCUAQ6>; Thu, 20 Mar 2003 19:16:58 -0500
Message-ID: <3E7A5C08.9060609@trash.net>
Date: Fri, 21 Mar 2003 01:25:44 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030318 Debian/1.3-2
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RESEND] [PATCH]: missing cli() in isdn_net.c
Content-Type: multipart/mixed;
 boundary="------------070404030705050805090508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070404030705050805090508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
this patch fixes a missing cli() in isdn_net.c.

Regards,
Patrick


--------------070404030705050805090508
Content-Type: text/plain;
 name="isdn-net-missing-cli.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isdn-net-missing-cli.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1053  -> 1.1054 
#	drivers/isdn/isdn_net.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/18	kaber@trash.net	1.1054
# [ISDN]: fix missing cli() in isdn_net.c
# --------------------------------------------
#
diff -Nru a/drivers/isdn/isdn_net.c b/drivers/isdn/isdn_net.c
--- a/drivers/isdn/isdn_net.c	Fri Mar 21 00:58:13 2003
+++ b/drivers/isdn/isdn_net.c	Fri Mar 21 00:58:13 2003
@@ -2831,6 +2831,7 @@
 
 			/* If binding is exclusive, try to grab the channel */
 			save_flags(flags);
+			cli();
 			if ((i = isdn_get_free_channel(ISDN_USAGE_NET,
 				lp->l2_proto, lp->l3_proto, drvidx,
 				chidx, lp->msn)) < 0) {

--------------070404030705050805090508--

