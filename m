Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbTBQQyJ>; Mon, 17 Feb 2003 11:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbTBQQyJ>; Mon, 17 Feb 2003 11:54:09 -0500
Received: from [81.2.122.30] ([81.2.122.30]:15366 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267187AbTBQQyI>;
	Mon, 17 Feb 2003 11:54:08 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302171705.h1HH5Isl010627@darkstar.example.net>
Subject: Re: Performance of ext3 on large systems
To: matti.aarnio@zmailer.org (Matti Aarnio)
Date: Mon, 17 Feb 2003 17:05:17 +0000 (GMT)
Cc: rml@tech9.net, sneakums@zork.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030217164740.GS1073@mea-ext.zmailer.org> from "Matti Aarnio" at Feb 17, 2003 06:47:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, yes, but that's not what I was saying - what was saying is that
> > if you are primarily reading anyway, there isn't much to be gained
> > from using EXT-3, over EXT-2.
> 
>   Besides of data robustness.

Well yes, but that only matters if the filesystem isn't unmounted
cleanly.

> > If you are primarily writing, EXT-3 atime should be faster than EXT-2
> > noatime.  EXT-3 notime will obviously be even faster.
> 
>   No.  For primarily writing the 'noatime' effect disappears in background
>   noice. Every time you write into file, mtime will be updated, and also
>   ctime.  Only one of i-node timestamps _not_ updated is atime...

Well, that's what I was implying, that for primarily writing, EXT-3
should be better than EXT-2, regardless of the atime configuration.

So, we agree :-).

John.
