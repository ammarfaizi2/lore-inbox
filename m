Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVCDM0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVCDM0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVCDMVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:21:00 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:18841 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262891AbVCDL6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:58:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: use non-contiguous memory on resume
Date: Fri, 4 Mar 2005 13:00:20 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hugang@soulinfo.com
References: <20050304095934.GA1731@elf.ucw.cz> <20050304032952.4b2e456b.akpm@osdl.org> <20050304115214.GA2168@elf.ucw.cz>
In-Reply-To: <20050304115214.GA2168@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503041300.20535.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 4 of March 2005 12:52, Pavel Machek wrote:
> Hi!
> 
> > > > > Problem is that pagedir is allocated as order-8 allocation on resume
> > > > >  in -mmX (and linus). Unfortunately, order-8 allocation sometimes
> > > > >  fails, and for some people (Rafael, seife :-) it fails way too often.
> > > > > 
> > > > >  Solution is to change format of pagedir from table to linklist,
> > > > >  avoiding high-order alocation. Unfortunately that means changes to
> > > > >  assembly, too, as assembly walks the pagedir.
> > > > 
> > > > Ah.
> > > > 
> > > > >  (Or maybe Rafael is willing to create -mm version and submit it
> > > > >  himself?)
> > > > 
> > > > No, against -linus, please.  But the chunk in kernel/power/swsusp.c looks
> > > > like it came from a diff between -mm and -linus.  Or something.
> > > 
> > > Yes, I did diff between -mm and -pavel, sorry.
> > > 
> > > But I can't easily generate diff against -linus because that one is
> > > dependend on fixing order-8 allocations during suspend. So I guess
> > > I'll just wait until that one propagates into -linus?
> > 
> > Just generate a patch series?
> 
> When #1 of the series is already in -mm? Okay, I guess we can do that.

Can I?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
