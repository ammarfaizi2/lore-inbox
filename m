Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315554AbSEHXPU>; Wed, 8 May 2002 19:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315555AbSEHXPT>; Wed, 8 May 2002 19:15:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42756 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315552AbSEHXPS>; Wed, 8 May 2002 19:15:18 -0400
Date: Thu, 9 May 2002 01:15:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading page from given block device
Message-ID: <20020508231520.GC11842@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020508204809.GA2300@elf.ucw.cz> <3CD996E5.BFB5CF9E@zip.com.au> <20020508225603.GA11842@atrey.karlin.mff.cuni.cz> <3CD9AE15.114D13E3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > It is swap partition, but system does not yet know its swap at that
> > point. This is next boot, that partition was not yet accessed.
> >                                                                 Pavel
> 
> In that case, I don't know.  Sorry.  sysrq-T is your
> friend (and kgdb is your god).  Let me know...

Call trace is 

c01229ed -- bdev_read_page
c0134b5b -- __bread

That's stable (as expected). Under that, it was seen in

c0134a57 -- __getblk
	    blk_get_queue
	    ata_get_queue

Second try:

c0134a28 -- __getblk
	    __get_hash_table

Third try:

c0134a28 -- __getblk
c01343cc -- __get_hash_table

Fourth try:

c0134abd -- __getblk

... I should get some sleep I guess...
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
