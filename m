Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVAFJ2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVAFJ2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbVAFJ2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:28:11 -0500
Received: from [213.146.154.40] ([213.146.154.40]:44195 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262796AbVAFJ16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:27:58 -0500
Date: Thu, 6 Jan 2005 09:27:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
Message-ID: <20050106092748.GA15162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050106002240.00ac4611.akpm@osdl.org> <41DD00DA.4070307@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DD00DA.4070307@eyal.emu.id.au>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 08:11:54PM +1100, Eyal Lebedinsky wrote:
> Surprisingly, this is what I get for 'make distclean':
> 
> scripts/Makefile.clean:10: fs/umsdos/Makefile: No such file or directory
> make[2]: *** No rule to make target `fs/umsdos/Makefile'.  Stop.
> make[1]: *** [fs/umsdos] Error 2
> make: *** [_clean_fs] Error 2
> 
> fs/umsdos is practically empty.

I forgot to remove umsdos from fs/Makefile.  Here's a patch:


--- 1.66/fs/Makefile	2005-01-05 03:48:08 +01:00
+++ edited/fs/Makefile	2005-01-06 10:33:33 +01:00
@@ -57,7 +57,6 @@
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
-obj-$(CONFIG_UMSDOS_FS)		+= umsdos/
 obj-$(CONFIG_MSDOS_FS)		+= msdos/
 obj-$(CONFIG_VFAT_FS)		+= vfat/
 obj-$(CONFIG_BFS_FS)		+= bfs/
