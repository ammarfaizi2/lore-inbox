Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbTAGRsv>; Tue, 7 Jan 2003 12:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbTAGRsv>; Tue, 7 Jan 2003 12:48:51 -0500
Received: from [81.2.122.30] ([81.2.122.30]:7686 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267473AbTAGRsu>;
	Tue, 7 Jan 2003 12:48:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301071757.h07HvU1l002172@darkstar.example.net>
Subject: Re: Undelete files on ext3 ??
To: maxvaldez@yahoo.com (Max Valdez)
Date: Tue, 7 Jan 2003 17:57:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1041961118.13635.10.camel@garaged.fis.unam.mx> from "Max Valdez" at Jan 07, 2003 11:38:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > By the way, there used to be undelete tool for ext2. It created a list
> > of deleted inodes with correct stat, but no names, only their inode
> > numbers. You could then pick the corect inode and give it a name, thus
> > bringing it back to life. Since ext3 is just ext2 with journal, I guess
> > it might work. It existed as a standalone tool and integrated to
> > midnight commander.

> I think there must be some other differences between ext2 and ext3, I've
> tryed e2undel and unrm, both made for ext2, and none of them found any
> deleted inode.
> 
> I umonted immediately the drive, and nothing has been writen on it after
> the rm *

Maybe it's not working because you need to flush the journal before
the ext2 tool will see the inode as deleted.  Alternatively, if that
is the case, perhaps by ignoring the data in the journal, the file
would not appear to be deleted.

Why not make a copy of the partition in to a file, and mount that file
using the loopback device - then you can try flushing the journal,
discarding the journal, etc.

John.
