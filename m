Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSIOEbL>; Sun, 15 Sep 2002 00:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSIOEbL>; Sun, 15 Sep 2002 00:31:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:13699 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317755AbSIOEbK>;
	Sun, 15 Sep 2002 00:31:10 -0400
Message-ID: <3D8411E3.5A26621D@digeo.com>
Date: Sat, 14 Sep 2002 21:51:47 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Nicholas Miell <nmiell@attbi.com>, Linus Torvalds <torvalds@transmeta.com>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] dump_stack(): arch-neutral stack trace
References: <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com> <1031618129.1403.12.camel@entropy> <3D7D447B.D7BD1C33@digeo.com> <E17qR7T-0001qf-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 04:35:58.0786 (UTC) FILETIME=[635C7A20:01C25C71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Tuesday 10 September 2002 03:01, Andrew Morton wrote:
> > From Christoph Hellwig, also present in 2.4.
> >
> > Create an arch-independent `dump_stack()' function.  So we don't need to do
> >
> > #ifdef CONFIG_X86
> >       show_stack(0);          /* No prototype in scope! */
> > #endif
> >
> > any more.
> >
> > The whole dump_stack() implementation is delegated to the architecture.
> > If it doesn't provide one, there is a default do-nothing library
> > function.
> 
> Is there a reason for not calling it "backtrace()" ?

In retrospect, no.  But it's called dump_stack() in 2.4 now.

-
