Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRBSQGN>; Mon, 19 Feb 2001 11:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129935AbRBSQGE>; Mon, 19 Feb 2001 11:06:04 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25617 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129896AbRBSQFn>; Mon, 19 Feb 2001 11:05:43 -0500
Subject: Re: Linux 2.4.1-ac15
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 19 Feb 2001 16:04:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        prumpf@mandrakesoft.com (Philipp Rumpf), linux-kernel@vger.kernel.org
In-Reply-To: <30069.982583679@ocs3.ocs-net> from "Keith Owens" at Feb 19, 2001 10:54:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UsnJ-0003l9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >At the same time another cpu may be walking the exception table that we free.
> 
> Another good reason why locking modules via use counts from external
> code is not the right fix.  We definitely need a quiesce model for
> module removal.

My spinlock based fix has almost no contention and doesnt require 64 processors
grind to a halt on a big machine just to handle a module list change. Sorry
I don't think it supports your argument

