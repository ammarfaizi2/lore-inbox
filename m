Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWGQQiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWGQQiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWGQQdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:64443 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750974AbWGQQdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:11 -0400
Date: Mon, 17 Jul 2006 09:26:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, marcelo@kvack.org,
       davem@davemloft.net
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, matthew@wil.cx,
       Willy Tarreau <w@1wt.eu>, Jeff Garzik <jeff@garzik.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/45] 2 oopses in ethtool
Message-ID: <20060717162645.GM4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="2-oopses-in-ethtool.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Willy Tarreau <willy@wtap.(none)>

The function pointers which were checked were for their get_* counterparts.
Typically a copy-paste typo.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Acked-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 net/core/ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.3.orig/net/core/ethtool.c
+++ linux-2.6.17.3/net/core/ethtool.c
@@ -437,7 +437,7 @@ static int ethtool_set_pauseparam(struct
 {
 	struct ethtool_pauseparam pauseparam;
 
-	if (!dev->ethtool_ops->get_pauseparam)
+	if (!dev->ethtool_ops->set_pauseparam)
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&pauseparam, useraddr, sizeof(pauseparam)))

--
