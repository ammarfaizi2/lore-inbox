Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266206AbUGAVam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUGAVam (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUGAVam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:30:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21482 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266206AbUGAVaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:30:39 -0400
Date: Thu, 1 Jul 2004 23:30:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [patch] 2.6.7-mm5: R8169_NAPI help text
Message-ID: <20040701213029.GV24147@fs.tum.de>
References: <20040630172656.6949ec60.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630172656.6949ec60.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 05:26:56PM -0700, Andrew Morton wrote:
>...
> -r8169_napi-help-text.patch
> 
>  This broke
>...

Below is a patch against -mm5.

Please apply
Adrian

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm5-full/drivers/net/Kconfig.old	2004-07-01 23:24:49.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/net/Kconfig	2004-07-01 23:25:38.000000000 +0200
@@ -2009,7 +2009,18 @@
 config R8169_NAPI
 	bool "Use Rx and Tx Polling (NAPI) (EXPERIMENTAL)"
 	depends on R8169 && EXPERIMENTAL 
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
 
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
 
 config SK98LIN
 	tristate "Marvell Yukon Chipset / SysKonnect SK-98xx Support"
