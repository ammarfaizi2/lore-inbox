Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWFUV5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWFUV5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWFUV5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:57:33 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48394 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030328AbWFUV5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:57:30 -0400
Date: Wed, 21 Jun 2006 23:57:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Thomas Kleffel <tk@maintech.de>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org
Subject: [-mm patch] drivers/ide/legacy/ide-cs.c: make 2 functions static
Message-ID: <20060621215729.GL9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
>  git-pcmcia.patch
>...
>  git trees
>...

This patch makes two needlessly global functions static.
 
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ide/legacy/ide-cs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-mm1-full/drivers/ide/legacy/ide-cs.c.old	2006-06-21 22:54:20.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/ide/legacy/ide-cs.c	2006-06-21 22:54:37.000000000 +0200
@@ -170,11 +170,11 @@
         return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
 }
 
-void outb_io(unsigned char value, unsigned long port) {
+static void outb_io(unsigned char value, unsigned long port) {
 	outb(value, port);
 }
 
-void outb_mem(unsigned char value, unsigned long port) {
+static void outb_mem(unsigned char value, unsigned long port) {
 	writeb(value, (void __iomem *) port);
 }
 

