Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbSLFGvQ>; Fri, 6 Dec 2002 01:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267617AbSLFGvQ>; Fri, 6 Dec 2002 01:51:16 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:9868 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S267613AbSLFGvP>; Fri, 6 Dec 2002 01:51:15 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5: ext3 bug or dying drive?
Date: Fri, 6 Dec 2002 08:01:06 +0100
User-Agent: KMail/1.4.3
References: <1039123660.1433.12.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212060801.06566@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von Robert Love:

> Overnight, 2.5.50-mm1 took a big stinky shit:

[bad things]

> Nothing particularly interesting was going on (mostly idle X desktop).
> I woke up and noticed the fs was mounted ro.  The above was in dmesg.
> 
> Rebooted and ext3 replayed the journal and said a manual check was
> needed due to I/O error on the journal.  Ran fsck manually, it found a
> whole bunch of orphan inodes including some scary errors like "inode
> part of corrupt orphan inode list" or similar.

>From at least (IIRC) 2.5.46 on I'm getting wrong free block counts in inodes 
if I'm writing to discs. Looks like it must be a bit more than just 2 or 20 
files, a kernel compile is enough in most cases. It's happening on 2 
different hosts, one with SCSI, the other one with IDE. Nothing really bad 
has happend until today. But if I can't create new files on a filesystem with 
2 GB of free space I know it's time for an "e2fsck -f" on it.

Eike
