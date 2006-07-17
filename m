Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWGQQlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWGQQlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWGQQkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:40:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:31164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750988AbWGQQda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:30 -0400
Date: Mon, 17 Jul 2006 09:27:02 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Thomas Graf <tgraf@suug.ch>,
       "David S. Miller" <davem@davemloft.net>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/45] PKT_SCHED: Return ENOENT if action module is unavailable
Message-ID: <20060717162702.GP4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pkt_sched-return-enoent-if-action-module-is-unavailable.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Thomas Graf <tgraf@suug.ch>

Return ENOENT if action module is unavailable

Signed-off-by: Thomas Graf <tgraf@suug.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/sched/act_api.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17.3.orig/net/sched/act_api.c
+++ linux-2.6.17.3/net/sched/act_api.c
@@ -306,6 +306,7 @@ struct tc_action *tcf_action_init_1(stru
 			goto err_mod;
 		}
 #endif
+		*err = -ENOENT;
 		goto err_out;
 	}
 

--
