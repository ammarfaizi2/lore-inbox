Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVCJAGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVCJAGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVCJAEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:04:32 -0500
Received: from nacho.zianet.com ([216.234.192.105]:11537 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S262431AbVCJAA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:00:26 -0500
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with PPPD on dialup with 2.6.11-bk1 and later; 2.6.11 is OK
Date: Wed, 9 Mar 2005 16:57:37 -0700
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503091657.37244.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier today, I reported "PPPD fails on recent 2.6.11-bk".  I've narrowed
the problem down to between 2.6.11 and 2.6.11-bk1.

I get this with 2.6.11-bk1: (two attempts)

Mar  9 16:34:32 spc pppd[1142]: pppd 2.4.1 started by steven, uid 501
Mar  9 16:34:32 spc pppd[1142]: Using interface ppp0
Mar  9 16:34:32 spc pppd[1142]: Connect: ppp0 <--> /dev/ttyS1
Mar  9 16:34:56 spc pppd[1142]: Hangup (SIGHUP)
Mar  9 16:34:56 spc pppd[1142]: Modem hangup
Mar  9 16:34:56 spc pppd[1142]: Connection terminated.
Mar  9 16:34:56 spc pppd[1142]: Exit.
Mar  9 16:35:44 spc pppd[1143]: pppd 2.4.1 started by steven, uid 501
Mar  9 16:35:44 spc pppd[1143]: Using interface ppp0
Mar  9 16:35:44 spc pppd[1143]: Connect: ppp0 <--> /dev/ttyS1
Mar  9 16:36:08 spc pppd[1143]: Hangup (SIGHUP)
Mar  9 16:36:08 spc pppd[1143]: Modem hangup
Mar  9 16:36:08 spc pppd[1143]: Connection terminated.
Mar  9 16:36:08 spc pppd[1143]: Exit.

2.6.11 works fine:

Mar  9 16:40:03 spc pppd[1106]: pppd 2.4.1 started by steven, uid 501
Mar  9 16:40:03 spc pppd[1106]: Using interface ppp0
Mar  9 16:40:03 spc pppd[1106]: Connect: ppp0 <--> /dev/ttyS1
Mar  9 16:40:03 spc pppd[1106]: kernel does not support PPP filtering
Mar  9 16:40:04 spc pppd[1106]: local  IP address 216.31.65.65
Mar  9 16:40:04 spc pppd[1106]: remote IP address 216.31.65.1
Mar  9 16:40:04 spc pppd[1106]: primary   DNS address 216.234.192.92
Mar  9 16:40:04 spc pppd[1106]: secondary DNS address 216.234.213.130

Steven
