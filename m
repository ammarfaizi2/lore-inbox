Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319839AbSINA4O>; Fri, 13 Sep 2002 20:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319841AbSINA4O>; Fri, 13 Sep 2002 20:56:14 -0400
Received: from web40502.mail.yahoo.com ([66.218.78.119]:22422 "HELO
	web40502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319839AbSINA4N>; Fri, 13 Sep 2002 20:56:13 -0400
Message-ID: <20020914010101.75725.qmail@web40502.mail.yahoo.com>
Date: Fri, 13 Sep 2002 18:01:01 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c (2.4.19)
To: matthias.andree@stud.uni-dortmund.de
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Second, why do we need to put the disks on standby before halting? I ask because putting
>To make the broken ones flush their caches...

The cleanup() function in ide-disk.c will flush the write cache. Also, would
someone please point me to some documentation that states the cache is flushed
when the disk is put in standby: when I called Maxtor about this, they said that
the cache is NOT flushed. BTW, if your disk is so broken as to require being put
in standby mode to flush its write cache, then you are at great risk for data
corruption.

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
