Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUHaUHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUHaUHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUHaUBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:01:07 -0400
Received: from verein.lst.de ([213.95.11.210]:42473 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267380AbUHaT6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:58:03 -0400
Date: Tue, 31 Aug 2004 21:57:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2: why is DIGIEPCA marked BROKEN?
Message-ID: <20040831195753.GA12499@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040830235426.441f5b51.akpm@osdl.org> <20040831174719.GG3466@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831174719.GG3466@fs.tum.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 07:47:19PM +0200, Adrian Bunk wrote:
> If I revert mark-pcxx-as-broken.patch, the driver compiles UP for me 
> with exactly zero errors or warnings.
> 
> @Christoph:
> Could you post the errors you observed?

Umm, sorry.   As the patch name says it should have marked the pcxx
driver (CONFIG_DIGI) as broken.

--- 1.49/drivers/char/Kconfig	2004-08-28 19:04:06 +02:00
+++ edited/drivers/char/Kconfig	2004-08-31 21:58:53 +02:00
@@ -157,7 +157,7 @@
 
 config DIGI
 	tristate "Digiboard PC/Xx Support"
-	depends on SERIAL_NONSTANDARD && DIGIEPCA=n && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD && DIGIEPCA=n && BROKEN
 	help
 	  This is a driver for the Digiboard PC/Xe, PC/Xi, and PC/Xeve cards
 	  that give you many serial ports. You would need something like this
