Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267302AbSLEMJd>; Thu, 5 Dec 2002 07:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267303AbSLEMJd>; Thu, 5 Dec 2002 07:09:33 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:49426 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S267302AbSLEMJb>; Thu, 5 Dec 2002 07:09:31 -0500
Message-ID: <3DEF43DE.130064D8@compuserve.com>
Date: Thu, 05 Dec 2002 07:17:34 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: Samium Gromoff <_deepfire@mail.ru>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Monitor utility (was Re: DAC960 at 2.5.50)
References: <E18HR1a-0005QL-00@f12.mail.ru> <20021203114201.A32313@acpi.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, all,
  Did you know about the DAC960 monitor utility?  I just ran across it
in the SuSE install set.  It's available from
http://varmon.sourceforge.net/

Looks like it's not being maintained anymore (and probably won't work
with the 2.5 driver yet?)

-- 
Kevin


Dave Olien wrote:
> 
> 
> 
> Let me know if you find any problems at all.  I'll try to
> address them.
> 
> I think the biggest "imperfection" is just the coding style of
> the whole driver.  I might submit some patches over time to clean
> up coding style.
> 
> The next problem is that it doesn't handle media errors yet.
> If you have a read or write failure because a sector on your disk
> is bad, it fails the entire read or write. With all the coalescing
> of requests that the block layer does, this might fail ALL of a
> really large transfer just because one sector is bad.
> 
> I'm working on a patch that retries failures section at a time,
> so that the failure will be more closely limited to the sector
> that is bad.
> 
> On Thu, Nov 28, 2002 at 06:56:22PM +0300, Samium Gromoff wrote:
> >  > Samium Gromoff...
> > > > > <alan@lxorguk.ukuu.org.uk>
> > > > >         [PATCH] update to OSDL DAC960 driver
> > > > >
> > > > >         Its not perfect but it works
> > > >    is it supposed to blow my data, or is it relatively safe to use?
> > >
> > > There have been a few poeple using this patch for about 5 versions of
> > > 2.5 so far.  I haven't done heavy testing myself, just booting and doing
> > > some other testing of modules and drivers.  I am running the DAC960 on
> > > my root/boot filesystem and haven't seen any problems yet.
> >   thank you. i`ll join the 2.5 DAC user crowd soon then :-)
> >
> > ---
> > regards,
> >    Samium Gromoff
