Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSFZPUf>; Wed, 26 Jun 2002 11:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316635AbSFZPUe>; Wed, 26 Jun 2002 11:20:34 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:53766
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S316632AbSFZPUb>; Wed, 26 Jun 2002 11:20:31 -0400
Subject: Re: MCE Error - 2.5.24 - Whats this?
From: Shawn Starr <spstarr@sh0n.net>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: alexander.riesen@synopsys.COM,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020626181559.M28720@mea-ext.zmailer.org>
References: <1025068858.5090.1.camel@coredump>
	<20020626075027.GA18667@riesen-pc.gr05.synopsys.com>
	<1025103458.31334.1.camel@unaropia> 
	<20020626181559.M28720@mea-ext.zmailer.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 26 Jun 2002 11:20:41 -0400
Message-Id: <1025104841.31340.4.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm, I don't recall turning on ECC in BIOS but I'll check later today.
But that doesn't appear serious in any case then.

The ram is 512MB DDR Registered but its non ECC.

Shawn.


On Wed, 2002-06-26 at 11:15, Matti Aarnio wrote:
> On Wed, Jun 26, 2002 at 10:57:37AM -0400, Shawn Starr wrote:
> > I don't understand that decoded result ;) 
> > 
> > Is it a phony result or is there a real problem with the CPU itself?
> > It's brand new!
> 
>    Bad ECC data.  Possibly you don't have ECC capable memory in the system
>    at all, but your BIOS has been set up to expect it.    Possibly the
>    new processor is marginal, possibly the new board is marginal...
> 
> > On Wed, 2002-06-26 at 03:50, Alex Riesen wrote:
> > > On Wed, Jun 26, 2002 at 01:20:57AM -0400, Shawn Starr wrote:
> > > > I got this message this evening from the syslog:
> > > > 
> > > > 
> > > > MCE: The hardware reports a non fatal, correctable incident occured on
> > > > CPU 0.
> > > > 
> > > > Bank 0: 9409c00000000136
> > > > 
> > > > 
> > > > Is this something I should be worried about?
> > > > 
> > > > Included is the standard dmesg.
> > > 
> > > Dave Jones had a small parser for these codes:
> > > http://www.codemonkey.org.uk/cruft/parsemce.c
> > > 
> > > And as it seems the parser lacks a bit of information to completely
> > > decode the message:
> > > 
> > > ~ ./parsemce
> > > Status: (4) Machine Check in progress.
> > > Restart IP invalid.
> > > parsebank(0): 9409c00000000136 @ 0
> > >         External tag parity error
> > >         Uncorrectable ECC error
> > >         CPU state corrupt. Restart not possible
> > >         MISC register information valid
> > >         Error not corrected.
> > >         Error overflow
> > >         Memory heirarchy error
> > >         Request: Generic error
> > >         Transaction type : Data
> > >         Memory/IO : I/O
> > > 
> > > > Linux version 2.5.24 (root@unknown) (gcc version 3.1) #1 Sat Jun 22 14:58:48 EDT 2002
> > > ...
> > > 
> > > -alex
> > > 
> > -- 
> > Shawn Starr, sh0n.net, <spstarr@sh0n.net>
> > Maintainer: -shawn kernel patches: http://xfs.sh0n.net/2.4/
> > Developer Support Engineer
> > Datawire Communication Networks Inc.
> > 10 Carlson Court, Suite 300
> > Toronto, ON, M9W 6L2
> > T: 416.213.2001 ext 179 F: 416.213.2008
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Shawn Starr, sh0n.net, <spstarr@sh0n.net>
Maintainer: -shawn kernel patches: http://xfs.sh0n.net/2.4/
Developer Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416.213.2001 ext 179 F: 416.213.2008

