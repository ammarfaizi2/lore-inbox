Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290017AbSAKQwn>; Fri, 11 Jan 2002 11:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290018AbSAKQwd>; Fri, 11 Jan 2002 11:52:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37382 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290017AbSAKQwR>; Fri, 11 Jan 2002 11:52:17 -0500
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
To: matthew@hairy.beasts.org (Matthew Kirkwood)
Date: Fri, 11 Jan 2002 17:03:45 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201111555310.4389-100000@sphinx.mythic-beasts.com> from "Matthew Kirkwood" at Jan 11, 2002 04:15:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P55l-0008Aq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rusty's idea is nice (though I think it'd be better
> with a filesystem than a device, so you can share
> names rather than file descriptors) but the page per
> lock seems like rather too much overhead.

I don't think its a big problem. A page gets you 256 locks or whatever the
number ends up as. For the case where you have many fine grained locks
between a group of threads thats great. You just parcel them out. If its
two processes just wanting a lock between them, well they get a page with
room for 256 lock objects, but they only want one. That doesn't matter. 
Its one page, if they need two or two hundred locks its stil one page.

Alan
