Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUGEW5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUGEW5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 18:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUGEW5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 18:57:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25063 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261932AbUGEW5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 18:57:05 -0400
Date: Tue, 6 Jul 2004 00:56:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.7-mm6: let CDROM_PKTCDVD depend on experimental
Message-ID: <20040705225654.GJ28324@fs.tum.de>
References: <20040705023120.34f7772b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 02:31:20AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.7-mm5:
>...
> +dvdrw-support-for-267-bk13.patch
> +cdrw-packet-writing-support-for-267-bk13.patch
> +dvd-rw-packet-writing-update.patch
> +fix-race-in-pktcdvd-kernel-thread-handling.patch
> +fix-open-close-races-in-pktcdvd.patch
> +packet-writing-review-fixups.patch
> +packet-writing-docco.patch
> 
>  DVD-RW/CD-RW packet writing support
>... 

CDROM_PKTCDVD seems to be a good candidate for depending on 
EXPERIMENTAL:

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full/drivers/block/Kconfig.old	2004-07-06 00:48:44.000000000 +0200
+++ linux-2.6.7-mm6-full/drivers/block/Kconfig	2004-07-06 00:51:51.000000000 +0200
@@ -342,6 +342,7 @@
 
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"
+	depends on EXPERIMENTAL
 	help
 	  If you have a CDROM drive that supports packet writing, say Y to
 	  include preliminary support. It should work with any MMC/Mt Fuji

