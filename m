Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbTBQQLN>; Mon, 17 Feb 2003 11:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbTBQQLN>; Mon, 17 Feb 2003 11:11:13 -0500
Received: from [81.2.122.30] ([81.2.122.30]:8710 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267124AbTBQQLM>;
	Mon, 17 Feb 2003 11:11:12 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302171622.h1HGMMA8010529@darkstar.example.net>
Subject: Re: Performance of ext3 on large systems
To: rml@tech9.net (Robert Love)
Date: Mon, 17 Feb 2003 16:22:22 +0000 (GMT)
Cc: sneakums@zork.net, linux-kernel@vger.kernel.org
In-Reply-To: <1045497374.12615.1.camel@phantasy> from "Robert Love" at Feb 17, 2003 10:56:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Actually, it makes sense in a way - noatime only speeds up reads, not
> > writes, (access time is always updated on a write), whereas a
> > journaled filesystem is presumably intended to be tuned for write
> > performance.  So, for it's intended usage, not implementing noatime
> > shouldn't be a huge problem, although it would be useful.
> 
> But updating the access time _is_ a write, even if its due to a read. 
> And using 'noatime' does help, and it is implemented.  I guess Andrew's
> statement was just misinterpreted, because this is what he said.

Well, yes, but that's not what I was saying - what was saying is that
if you are primarily reading anyway, there isn't much to be gained
from using EXT-3, over EXT-2.

If you are primarily writing, EXT-3 atime should be faster than EXT-2
noatime.  EXT-3 notime will obviously be even faster.

John.
