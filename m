Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbUASNph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUASNph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:45:37 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:63500 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264942AbUASNpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:45:33 -0500
Date: Mon, 19 Jan 2004 22:46:03 +0900 (JST)
Message-Id: <20040119.224603.71004956.yoshfuji@linux-ipv6.org>
To: marcel@holtmann.org, davem@redhat.com
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: Problem with CONFIG_SYSCTL disabled
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1074519043.6070.93.camel@pegasus>
References: <1074519043.6070.93.camel@pegasus>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1074519043.6070.93.camel@pegasus> (at Mon, 19 Jan 2004 14:30:43 +0100), Marcel Holtmann <marcel@holtmann.org> says:

> 	In file included from drivers/net/net_init.c:53:
> 	include/net/neighbour.h:216: error: parse error before "proc_handler"
> 	include/net/neighbour.h:216: warning: function declaration isn't a prototype

===== include/net/neighbour.h 1.5 vs edited =====
--- 1.5/include/net/neighbour.h	Thu Jan 15 17:58:09 2004
+++ edited/include/net/neighbour.h	Mon Jan 19 22:42:24 2004
@@ -47,9 +47,7 @@
 #include <linux/skbuff.h>
 
 #include <linux/err.h>
-#ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
-#endif
 
 #define NUD_IN_TIMER	(NUD_INCOMPLETE|NUD_DELAY|NUD_PROBE)
 #define NUD_VALID	(NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE|NUD_PROBE|NUD_STALE|NUD_DELAY)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
