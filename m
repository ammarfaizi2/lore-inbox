Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUHPKpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUHPKpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUHPKpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:45:03 -0400
Received: from mail.dif.dk ([193.138.115.101]:35479 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267517AbUHPKog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:44:36 -0400
Date: Mon, 16 Aug 2004 12:48:34 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Glyph Lefkowitz <glyph@divmod.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistency in thread/signal interaction in 2.6.5 and previous
 vs. 2.6.6 and later (possibly a bug?)
In-Reply-To: <1092650465.3394.13.camel@localhost>
Message-ID: <Pine.LNX.4.61.0408161247040.2666@dragon.hygekrogen.localhost>
References: <1092650465.3394.13.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Glyph Lefkowitz wrote:

> Hello Kernel People,
> 
> Firstly, here is a brief example of some code that behaves very
> differently on 2.6.5 and 2.6.6:
> 
> http://www.twistedmatrix.com/users/glyph/signal-bug.c
> 
> I have verified that it says "Completed" on kernel 2.6.5, 2.6.3 and
> 2.6.1, and says "Died" on 2.6.6, 2.6.7 and 2.6.8.1, so I am pretty sure
> the difference is between 2.5.6 and 2.6.6.
> 
FYI : 

juhl@dragon:~$ gcc signal-bug.c -Wall -lutil -lpthread -o signal-bug; ./signal-bug
Completed.
juhl@dragon:~$ cat /proc/version
Linux version 2.6.8.1 (juhl@dragon) (gcc version 3.4.1) #1 Sun Aug 15 22:01:56 CEST 2004

glibc is 2.3.2


--
Jesper Juhl <juhl-lkml@dif.dk>


