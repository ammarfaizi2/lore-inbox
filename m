Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUGAVgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUGAVgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUGAVgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:36:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17130 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266295AbUGAVfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:35:40 -0400
Date: Thu, 1 Jul 2004 23:35:30 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [patch] 2.6.7-mm5: R8169_NAPI help text
Message-ID: <20040701213529.GW24147@fs.tum.de>
References: <20040630172656.6949ec60.akpm@osdl.org> <20040701213029.GV24147@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701213029.GV24147@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 11:30:29PM +0200, Adrian Bunk wrote:
> On Wed, Jun 30, 2004 at 05:26:56PM -0700, Andrew Morton wrote:
> >...
> > -r8169_napi-help-text.patch
> > 
> >  This broke
> >...
>...

Sorry, wrong patch.

Correct patch below.

cu
Adrian


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm5-full/drivers/net/Kconfig.old	2004-07-01 23:24:49.000000000 +0200
+++ linux-2.6.7-mm5-full/drivers/net/Kconfig	2004-07-01 23:31:52.000000000 +0200
@@ -2008,8 +2008,20 @@
 
 config R8169_NAPI
 	bool "Use Rx and Tx Polling (NAPI) (EXPERIMENTAL)"
-	depends on R8169 && EXPERIMENTAL 
+	depends on R8169 && EXPERIMENTAL
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
 
+	  If in doubt, say N.
 
 config SK98LIN
 	tristate "Marvell Yukon Chipset / SysKonnect SK-98xx Support"
