Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUGIU42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUGIU42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUGIU41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:56:27 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:58760 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S264665AbUGIU40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:56:26 -0400
Date: Fri, 9 Jul 2004 22:54:04 +0200
To: akpm@osdl.org
Cc: Valdis.Kletnieks@vt.edu, jsimmons@infradead.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Kill off CONFIG_PCI_CONSOLE
Message-ID: <20040709205404.GA1592@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Around the 2.6.0-test8 time-frame, Valdis Kletnieks noted that
CONFIG_PCI_CONSOLE was actually dead code[1].  James Simmons
agreed with this and went on to remark that this'd die off
unless someone spoke up.  No one has done so ever since.

Against 2.6.7. Thanks.

  [1] http://www.uwsg.iu.edu/hypermail/linux/kernel/0310.2/1042.html

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 Kconfig |    5 -----
 1 files changed, 5 deletions(-)

--- a/drivers/video/console/Kconfig	2004-04-11 14:04:22.000000000 +0200
+++ b/drivers/video/console/Kconfig	2004-02-11 15:38:53.000000000 +0100
@@ -106,11 +106,6 @@ config FRAMEBUFFER_CONSOLE
 	tristate "Framebuffer Console support"
 	depends on FB
 
-config PCI_CONSOLE
-	bool
-	depends on FRAMEBUFFER_CONSOLE
-	default y
-
 config FONTS
 	bool "Select compiled-in fonts"
 	depends on FRAMEBUFFER_CONSOLE
