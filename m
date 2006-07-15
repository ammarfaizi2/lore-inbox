Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946006AbWGOHlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946006AbWGOHlS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 03:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946005AbWGOHlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 03:41:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19687 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946004AbWGOHlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 03:41:17 -0400
Date: Sat, 15 Jul 2006 03:41:12 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: netdev <netdev@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: sch_htb compile fix.
Message-ID: <20060715074112.GA18210@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/sched/sch_htb.c: In function 'htb_change_class':
net/sched/sch_htb.c:1605: error: expected ';' before 'do_gettimeofday'

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/net/sched/sch_htb.c~	2006-07-15 03:40:14.000000000 -0400
+++ linux-2.6.17.noarch/net/sched/sch_htb.c	2006-07-15 03:40:21.000000000 -0400
@@ -1601,7 +1601,7 @@ static int htb_change_class(struct Qdisc
 		/* set class to be in HTB_CAN_SEND state */
 		cl->tokens = hopt->buffer;
 		cl->ctokens = hopt->cbuffer;
-		cl->mbuffer = PSCHED_JIFFIE2US(HZ*60) /* 1min */
+		cl->mbuffer = PSCHED_JIFFIE2US(HZ*60); /* 1min */
 		PSCHED_GET_TIME(cl->t_c);
 		cl->cmode = HTB_CAN_SEND;
-- 
http://www.codemonkey.org.uk
