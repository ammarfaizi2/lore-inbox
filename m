Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVAGMpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVAGMpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVAGMpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:45:33 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:63389 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261393AbVAGMpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:45:21 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.10-mm2: swsusp regression
Date: Fri, 7 Jan 2005 13:45:39 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050106002240.00ac4611.akpm@osdl.org> <200501070041.43023.rjw@sisk.pl> <20050106234829.GF28777@elf.ucw.cz>
In-Reply-To: <20050106234829.GF28777@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501071345.39847.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 7 of January 2005 00:48, Pavel Machek wrote:
> Hi!
> 
> > 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
> > > > > 
> > > > > - Various minorish updates and fixes
> > > > 
> > > > There's an swsusp regression on my box (AMD64) wrt -mm1.  Namely, 
> > 2.6.10-mm2 
> > > > does not suspend, but hangs solid right after the critical section, 
100% 
> > of 
> > > > the time.
> > > 
> > > can you comment out device_power_{down,up} from
> > > swsusp_{suspend,resume} and see what happens?
> > 
> > It works just fine.
> 
> Ok, problem is that device_power_{down,up} is right thing, and
> neccessary for many machines to work...

It's OK, as long as I know what to comment out. ;-)

> ..so... could you go through sysdev_register()s, one by one,
> commenting them to see which one causes the regression? That driver
> then needs to be fixed.
> 
> Go after mtrr and time in first places.

OK, but it'll take some time.

> 								Pavel
> PS: Probably drop andrew from reply; he probably gets enough mail
> anyway. I want this one to go to him so that he does not back up the
> patch, through.

OK

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
