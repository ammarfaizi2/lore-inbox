Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbTCXHVy>; Mon, 24 Mar 2003 02:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261468AbTCXHVy>; Mon, 24 Mar 2003 02:21:54 -0500
Received: from angband.namesys.com ([212.16.7.85]:49290 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261341AbTCXHVx>; Mon, 24 Mar 2003 02:21:53 -0500
Date: Mon, 24 Mar 2003 10:32:55 +0300
From: Oleg Drokin <green@namesys.com>
To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] devfs_mk_symlink simplification
Message-ID: <20030324103255.A20753@namesys.com>
References: <20030322183938.B21623@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322183938.B21623@lst.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Mar 22, 2003 at 06:39:38PM +0100, Christoph Hellwig wrote:
> All devfs_mk_symlink arguments except the from and to strings are
> unused.  Bring the prototype in shape.

This patch is needed in UML subtree now:

Bye,
    Oleg
===== arch/um/drivers/ubd_kern.c 1.33 vs edited =====
--- 1.33/arch/um/drivers/ubd_kern.c	Mon Mar 24 09:42:10 2003
+++ edited/arch/um/drivers/ubd_kern.c	Mon Mar 24 10:26:25 2003
@@ -577,7 +577,7 @@
 	sprintf(link, "ubd/disc%d", n);
 
 	/* and we link it to /dev/ubd/discN */
-	devfs_mk_symlink(NULL, link, DEVFS_FL_DEFAULT, real, NULL, NULL);
+	devfs_mk_symlink(link, real);
 	if (fake_major != MAJOR_NR) {
 		/* /dev/fakeN style names */
 		sprintf(real, "fake%d",n);
