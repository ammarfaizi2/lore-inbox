Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946373AbWKAFhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946373AbWKAFhS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946369AbWKAFhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:37:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:65424 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946221AbWKAFhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:37:03 -0500
Message-Id: <20061101053720.411825000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:55 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/61] sky2: GMAC pause frame
Content-Disposition: inline; filename=sky2-gmac-pause-frame.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stephen Hemminger <shemminger@osdl.org>

This reverts earlier change that attempted to fix flow control.
Device needs to discard pause frames, otherwise it passes pause frames up
the stack.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>


---
 drivers/net/sky2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.1.orig/drivers/net/sky2.h
+++ linux-2.6.18.1/drivers/net/sky2.h
@@ -1566,7 +1566,7 @@ enum {
 
 	GMR_FS_ANY_ERR	= GMR_FS_RX_FF_OV | GMR_FS_CRC_ERR |
 			  GMR_FS_FRAGMENT | GMR_FS_LONG_ERR |
-		  	  GMR_FS_MII_ERR | GMR_FS_BAD_FC |
+		  	  GMR_FS_MII_ERR | GMR_FS_GOOD_FC | GMR_FS_BAD_FC |
 			  GMR_FS_UN_SIZE | GMR_FS_JABBER,
 };
 

--
