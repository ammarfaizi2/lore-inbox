Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSFZPQA>; Wed, 26 Jun 2002 11:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSFZPQA>; Wed, 26 Jun 2002 11:16:00 -0400
Received: from mail.zmailer.org ([62.240.94.4]:59318 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S316623AbSFZPP6>;
	Wed, 26 Jun 2002 11:15:58 -0400
Date: Wed, 26 Jun 2002 18:15:59 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Shawn Starr <spstarr@sh0n.net>
Cc: alexander.riesen@synopsys.COM,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MCE Error - 2.5.24 - Whats this?
Message-ID: <20020626181559.M28720@mea-ext.zmailer.org>
References: <1025068858.5090.1.camel@coredump> <20020626075027.GA18667@riesen-pc.gr05.synopsys.com> <1025103458.31334.1.camel@unaropia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025103458.31334.1.camel@unaropia>; from spstarr@sh0n.net on Wed, Jun 26, 2002 at 10:57:37AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 10:57:37AM -0400, Shawn Starr wrote:
> I don't understand that decoded result ;) 
> 
> Is it a phony result or is there a real problem with the CPU itself?
> It's brand new!

   Bad ECC data.  Possibly you don't have ECC capable memory in the system
   at all, but your BIOS has been set up to expect it.    Possibly the
   new processor is marginal, possibly the new board is marginal...

> On Wed, 2002-06-26 at 03:50, Alex Riesen wrote:
> > On Wed, Jun 26, 2002 at 01:20:57AM -0400, Shawn Starr wrote:
> > > I got this message this evening from the syslog:
> > > 
> > > 
> > > MCE: The hardware reports a non fatal, correctable incident occured on
> > > CPU 0.
> > > 
> > > Bank 0: 9409c00000000136
> > > 
> > > 
> > > Is this something I should be worried about?
> > > 
> > > Included is the standard dmesg.
> > 
> > Dave Jones had a small parser for these codes:
> > http://www.codemonkey.org.uk/cruft/parsemce.c
> > 
> > And as it seems the parser lacks a bit of information to completely
> > decode the message:
> > 
> > ~ ./parsemce
> > Status: (4) Machine Check in progress.
> > Restart IP invalid.
> > parsebank(0): 9409c00000000136 @ 0
> >         External tag parity error
> >         Uncorrectable ECC error
> >         CPU state corrupt. Restart not possible
> >         MISC register information valid
> >         Error not corrected.
> >         Error overflow
> >         Memory heirarchy error
> >         Request: Generic error
> >         Transaction type : Data
> >         Memory/IO : I/O
> > 
> > > Linux version 2.5.24 (root@unknown) (gcc version 3.1) #1 Sat Jun 22 14:58:48 EDT 2002
> > ...
> > 
> > -alex
> > 
> -- 
> Shawn Starr, sh0n.net, <spstarr@sh0n.net>
> Maintainer: -shawn kernel patches: http://xfs.sh0n.net/2.4/
> Developer Support Engineer
> Datawire Communication Networks Inc.
> 10 Carlson Court, Suite 300
> Toronto, ON, M9W 6L2
> T: 416.213.2001 ext 179 F: 416.213.2008
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
