Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289051AbSAKK1l>; Fri, 11 Jan 2002 05:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289124AbSAKK1c>; Fri, 11 Jan 2002 05:27:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:30936 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289051AbSAKK1S>;
	Fri, 11 Jan 2002 05:27:18 -0500
Date: Fri, 11 Jan 2002 02:08:39 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Hans Reiser <reiser@namesys.com>
cc: "W. Wilson Ho" <ho@routefree.com>, "Gryaznova E." <grev@namesys.botik.ru>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [reiserfs-list] Re: elevator algorithm in
 disk controller bad?
In-Reply-To: <3C3EAB55.9070704@namesys.com>
Message-ID: <Pine.LNX.4.10.10201110157240.9366-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You mean like this ??

ide.2.4.0-ac10.all.01212001.patch:
+static int do_flush_cache(ide_drive_t *drive);
ide.2.4.0-ac10.all.01212001.patch:
+ (do_flush_cache(drive)) ? "SUCCESSED" : "FAILED");
ide.2.4.0-ac10.all.01212001.patch:
+static int do_flush_cache (ide_drive_t *drive)
ide.2.4.0-ac10.all.01212001.patch:
+ (do_flush_cache(drive)) ? "SUCCESSED" : "FAILED");
ide.2.4.0-ac10.all.01212001.patch:
-              * all current requests to be flushed from the queue.
ide.2.4.0-ac10.all.01212001.patch:
+      * all current requests to be flushed from the queue.

Or something more up to date?

ide.2.4.16.12102001.patch:+     flushcache:             NULL,
ide.2.4.16.12102001.patch:+static int do_idedisk_flushcache(ide_drive_t *drive);
ide.2.4.16.12102001.patch:+             if (do_idedisk_flushcache(drive))
ide.2.4.16.12102001.patch:+static int do_idedisk_flushcache (ide_drive_t *drive)
ide.2.4.16.12102001.patch:+             if (do_idedisk_flushcache(drive))
ide.2.4.16.12102001.patch:+     flushcache:             do_idedisk_flushcache,
ide.2.4.16.12102001.patch:+     flushcache:             NULL,
ide.2.4.16.12102001.patch:+     flushcache:             NULL,

 On Fri, 11 Jan 2002, Hans Reiser wrote:

> Andre, have you had a chance to put in the the cache flushing stuff into 
> your IDE code?
> 
> Hans

<snip>

This code as only been available for a year or so ...

Regards,

Andre Hedrick
Linux ATA Development

