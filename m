Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUEFPNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUEFPNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUEFPNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:13:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:43484 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262459AbUEFPNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:13:20 -0400
Date: Thu, 6 May 2004 08:12:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Antonio Dolcetta <adolcetta@infracom.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-Id: <20040506081258.569d696e.akpm@osdl.org>
In-Reply-To: <20040506165304.6376fed1@simbad>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<20040506165304.6376fed1@simbad>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Dolcetta <adolcetta@infracom.it> wrote:
>
> something has broken the b44 module,
>  modprobe b44 fails with:
>  FATAL: Error inserting b44 (/lib/modules/2.6.6-rc3-mm2/kernel/drivers/net/b44.ko): Unknown symbol in module, or unknown parameter (see dmesg)
> 
>  dmesg contains the line:
>  b44: Unknown symbol generic_mii_ioctl

Please config that your .config does not set CONFIG_MII?


 25-akpm/drivers/net/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/net/Kconfig~b44-needs-mii drivers/net/Kconfig
--- 25/drivers/net/Kconfig~b44-needs-mii	2004-05-06 08:12:07.298682840 -0700
+++ 25-akpm/drivers/net/Kconfig	2004-05-06 08:12:15.841384152 -0700
@@ -1309,6 +1309,7 @@ config APRICOT
 config B44
 	tristate "Broadcom 4400 ethernet support (EXPERIMENTAL)"
 	depends on NET_PCI && PCI && EXPERIMENTAL
+	select MII
 	help
 	  If you have a network (Ethernet) controller of this type, say Y and
 	  read the Ethernet-HOWTO, available from

_

