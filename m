Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267138AbTBQQiB>; Mon, 17 Feb 2003 11:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbTBQQiA>; Mon, 17 Feb 2003 11:38:00 -0500
Received: from mail.zmailer.org ([62.240.94.4]:6044 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267138AbTBQQiA>;
	Mon, 17 Feb 2003 11:38:00 -0500
Date: Mon, 17 Feb 2003 18:47:40 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: John Bradford <john@grabjohn.com>
Cc: Robert Love <rml@tech9.net>, sneakums@zork.net,
       linux-kernel@vger.kernel.org
Subject: Re: Performance of ext3 on large systems
Message-ID: <20030217164740.GS1073@mea-ext.zmailer.org>
References: <1045497374.12615.1.camel@phantasy> <200302171622.h1HGMMA8010529@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302171622.h1HGMMA8010529@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 04:22:22PM +0000, John Bradford wrote:
...
> Well, yes, but that's not what I was saying - what was saying is that
> if you are primarily reading anyway, there isn't much to be gained
> from using EXT-3, over EXT-2.

  Besides of data robustness.

> If you are primarily writing, EXT-3 atime should be faster than EXT-2
> noatime.  EXT-3 notime will obviously be even faster.

  No.  For primarily writing the 'noatime' effect disappears in background
  noice. Every time you write into file, mtime will be updated, and also
  ctime.  Only one of i-node timestamps _not_ updated is atime...

> John.

/Matti Aarnio
