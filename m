Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319700AbSIMPOY>; Fri, 13 Sep 2002 11:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319703AbSIMPOY>; Fri, 13 Sep 2002 11:14:24 -0400
Received: from web40502.mail.yahoo.com ([66.218.78.119]:43587 "HELO
	web40502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319700AbSIMPOT>; Fri, 13 Sep 2002 11:14:19 -0400
Message-ID: <20020913151906.61067.qmail@web40502.mail.yahoo.com>
Date: Fri, 13 Sep 2002 08:19:06 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c (2.4.19)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1031922553.9056.18.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> To make sure they have written back their caches...

This is redundant, since cleanup() flushes the write cache. Also, I spoke to a 
Maxtor tech support person and he said that putting the drives in standby mode
does NOT flush the write cache. Yet another thing: you are flushing the cache,
by calling cleanup(), AFTER you put the disks to sleep. I think that's backward.

I guess the gist of my monlogue is: has anybody reported a problem that has been
solved by putting the disks to sleep??

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
