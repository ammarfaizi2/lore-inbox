Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131222AbQLRBDk>; Sun, 17 Dec 2000 20:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132398AbQLRBDa>; Sun, 17 Dec 2000 20:03:30 -0500
Received: from rsn-rby-gw.hk-r.se ([194.47.128.222]:19890 "EHLO
	tux.rsn.hk-r.se") by vger.kernel.org with ESMTP id <S131222AbQLRBDR>;
	Sun, 17 Dec 2000 20:03:17 -0500
Date: Mon, 18 Dec 2000 01:32:00 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre3 and ext2 as module
In-Reply-To: <Pine.LNX.4.21.0012180119320.26302-100000@tux.rsn.hk-r.se>
Message-ID: <Pine.LNX.4.21.0012180128510.26302-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Linus, will you please consider this patch by Jeff Raubitschek for the
next pre-patch? It fixes two unresolved symbols in ext2.o when building
ext2 as a module.

--- linux-2.4.0-test12/kernel/ksyms.c   Tue Dec 12 11:19:17 2000
+++ linux/kernel/ksyms.c        Tue Dec 12 11:18:57 2000
@@ -252,6 +252,8 @@
 EXPORT_SYMBOL(lock_may_read);
 EXPORT_SYMBOL(lock_may_write);
 EXPORT_SYMBOL(dcache_readdir);
+EXPORT_SYMBOL(buffer_insert_inode_queue);
+EXPORT_SYMBOL(fsync_inode_buffers);
 
 /* for stackable file systems (lofs, wrapfs, cryptfs, etc.) */
 EXPORT_SYMBOL(default_llseek);


/Martin

Linux hackers are funny people: They count the time in patchlevels.

On Mon, 18 Dec 2000, Martin Josefsson wrote:

> On Mon, 18 Dec 2000, Martin Josefsson wrote:
> 
> > On Mon, 18 Dec 2000, Alan Cox wrote:
> > 
> > > > I compiled test13-pre3 a few minutes ago and when running
> > > > make modules_install I got this:
> > > > 
> > > > depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre3/kernel/fs/ext2/ext2.o
> > > > depmod:         buffer_insert_inode_queue
> > > > depmod:         fsync_inode_buffers
> > > 
> > > Jeff Raubitschek posted a patch for this on the 12th. 
> > 
> > Thanks for the quick response, testing the patch now.
> > If it works I'll ask Linux to include it in the next pre-patch
> 
> Gaah, why do I write Linux instead of Linus... maybe I should get some
> sleep..
> 
> /Martin
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
