Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSEJRIj>; Fri, 10 May 2002 13:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316071AbSEJRIj>; Fri, 10 May 2002 13:08:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42689 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316070AbSEJRIi>;
	Fri, 10 May 2002 13:08:38 -0400
Date: Fri, 10 May 2002 09:56:00 -0700 (PDT)
Message-Id: <20020510.095600.90795538.davem@redhat.com>
To: macro@ds2.pg.gda.pl
Cc: dizzy@roedu.net, linux-kernel@vger.kernel.org
Subject: Re: mmap, SIGBUS, and handling it
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.3.96.1020510183538.13449A-100000@delta.ds2.pg.gda.pl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
   Date: Fri, 10 May 2002 19:03:19 +0200 (MET DST)

   On Fri, 10 May 2002, David S. Miller wrote:
   
   > If we reexecute the instruction it will take the signal endlessly,
   > forever.  That makes no sense.
   
    It depends on an application.  It certainly shouldn't be the default, but
   a user may choose such an option for some reason.  E.g. for debugging a
   system with an ICE or a similar tool.
   
He's talking about how SIG_IGN should behave.

If you want non-default behavior, specify a signal handler instead
of SIG_IGN.
   
   > So my original point I was trying to make, which still stands, is that
   > what is being requested is totally rediculious behavior, trying to
   > ignore a page fault that can't be serviced.
   
    Why should we enforce policy on a user?  If one wants to ignore such
   signals for whatever reason, let him do that. 
   
We don't specify any policy other than the behavior of SIG_IGN which
is to kill off the process for SIGBUS.

If you specify a handler you can have SIGBUS do whatever you want it
to.  There are no enforced limitations, only a specified behavior
for SIG_IGN when used for SIGBUS.

The original poster has solved his problem, yet you continue to argue
one and on and on.
