Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbTAHKtB>; Wed, 8 Jan 2003 05:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbTAHKtB>; Wed, 8 Jan 2003 05:49:01 -0500
Received: from [81.2.122.30] ([81.2.122.30]:26116 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265222AbTAHKtA>;
	Wed, 8 Jan 2003 05:49:00 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301081057.h08Av1og000585@darkstar.example.net>
Subject: Re: Undelete files on ext3 ??
To: bulb@ucw.cz (Jan Hudec)
Date: Wed, 8 Jan 2003 10:57:01 +0000 (GMT)
Cc: gmack@innerfire.net, adilger@clusterfs.com, root@chaos.analogic.com,
       maxvaldez@yahoo.com, bulb@ucw.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20030108080005.GK2141@vagabond> from "Jan Hudec" at Jan 08, 2003 09:00:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Therefore, it's time for somebody to put a 'dumpster` in all the Linux
> > > > file-systems.  Somebody should then modify `rm` and the kernel unlink
> > > > to `mv' files to the dumpster directory on the file-system, instead of
> > > > really deleting them.

[snip discussion about a temporary directory for deleted files]

> Yes. But we could do better. Since no program uses the __syscall
> interface directly, wraping unlink in libc would affect all programs
> including rm. It could even be done withou recompiling anything using
> LD_PRELOAD.

I disagree.  This is the wrong goal to be aiming for.

A temporary directory for deleted files can, and should be,
implemented in userspace.

What is much more interesting is the possibility of what I described
earlier in the thread as a virtual WORM device, and what Andreas
said could be done with LVM already using filesystem snapshots -
I.E. the ability to mount the filesystem as it was at any date and
time in the past.

However, as far as I can see, LVM snapshots are a manual process - the
user has to expressly create a snapshot when they want it.

What I was thinking of was a virtual device that allocated a new
sector whenever an old one was overwritten - kind of like a journaled
filesystem, but without the filesystem, (I.E. just the journal) :-).

John.
