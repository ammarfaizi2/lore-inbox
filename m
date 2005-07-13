Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVGMVQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVGMVQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVGMSp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:45:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:12515 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262311AbVGMSou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:44:50 -0400
Date: Wed, 13 Jul 2005 11:43:31 -0700
From: Greg KH <gregkh@suse.de>
To: ralf@linux-mips.org, netdev@vger.kernel.org, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [05/11] SMP fix for 6pack driver
Message-ID: <20050713184331.GG9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


Drivers really only work well in SMP if they actually can be selected.
This is a leftover from the time when the 6pack drive only used to be
a bitrotten variant of the slip driver.

Signed-off-by: Ralf Baechle DL5RB <ralf@linux-mips.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/net/hamradio/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12.2.orig/drivers/net/hamradio/Kconfig	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/drivers/net/hamradio/Kconfig	2005-07-13 10:56:32.000000000 -0700
@@ -17,7 +17,7 @@
 
 config 6PACK
 	tristate "Serial port 6PACK driver"
-	depends on AX25 && BROKEN_ON_SMP
+	depends on AX25
 	---help---
 	  6pack is a transmission protocol for the data exchange between your
 	  PC and your TNC (the Terminal Node Controller acts as a kind of
