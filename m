Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131347AbRDGUU5>; Sat, 7 Apr 2001 16:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbRDGUUr>; Sat, 7 Apr 2001 16:20:47 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:18697 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131347AbRDGUU3>; Sat, 7 Apr 2001 16:20:29 -0400
Message-ID: <3ACF76B7.44F6279@t-online.de>
Date: Sat, 07 Apr 2001 22:21:11 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <20010407200340.C3280@redhat.com> <3ACF6920.465635A1@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Tim Waugh wrote:
> > It would allow support for new multi-IO cards to generally be the
> > addition of about two lines to two files (which is currently how it's
> > done), rather than having separate mutant hybrid monstrosity drivers
> > for each card (IMHO)..
> 
> ;-)
> 
> My point of view is that hacking the kernel so that two device drivers
> can pretend they are not driving the same hardware is silly.  With such
> hardware there are always inter-dependencies, and you can either hack
> special case code into two or more drivers, or create one central
> control point from which knowledge is dispatched.  Like I mentioned in a

My point of view is making it easy for the average user.
This is the same as making it easy for maintainers of hardware drivers !

More module interdependencies == More complicated == More clueless users

Many users will be surprised if they must load another module (e.g."pci_multiio")
to get their parallel and serial ports working.

Thus _must not_ happen in the stable release.

Regards, Gunther
