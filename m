Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319688AbSIMQJM>; Fri, 13 Sep 2002 12:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319691AbSIMQJM>; Fri, 13 Sep 2002 12:09:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:31997
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319688AbSIMQJM>; Fri, 13 Sep 2002 12:09:12 -0400
Subject: Re: Possible bug and question about ide_notify_reboot in
	drivers/ide/ide.c (2.4.19)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020913151906.61067.qmail@web40502.mail.yahoo.com>
References: <20020913151906.61067.qmail@web40502.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 13 Sep 2002 17:15:17 +0100
Message-Id: <1031933717.9991.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 16:19, Alex Davis wrote:
> 
> --- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > To make sure they have written back their caches...
> 
> This is redundant, since cleanup() flushes the write cache. Also, I spoke to a 
> Maxtor tech support person and he said that putting the drives in standby mode
> does NOT flush the write cache. 

Whether we should be putting drives in Standby is an Andre question I
think. One dodgy bios isnt a good reason to change it


>  Yet another thing: you are flushing the cache,
> by calling cleanup(), AFTER you put the disks to sleep. I think that's backward.

That would be a bug, but the 2.4.19 IDE code isnt my problem

Alan

