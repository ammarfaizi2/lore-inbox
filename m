Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316982AbSEWStC>; Thu, 23 May 2002 14:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316983AbSEWStB>; Thu, 23 May 2002 14:49:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35596 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316982AbSEWStA>;
	Thu, 23 May 2002 14:49:00 -0400
Message-ID: <3CED3954.44998141@zip.com.au>
Date: Thu, 23 May 2002 11:47:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hilbert Barelds <hilbert@hjb-design.com>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.19-pre8 reboots instead of halt and 3com messages
In-Reply-To: <Pine.LNX.4.44.0205231345400.23578-100000@netfinity.realnet.co.sz> <1022170254.1806.0.camel@calvin.hjblocal.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hilbert Barelds wrote:
> 
> On Thu, 2002-05-23 at 13:48, Zwane Mwaikambo wrote:
> > On Thu, 23 May 2002 hilbert@hjb-design.com wrote:
> >
> > > PS The 3com card complains about a "transpoder" x times.
> >
> > Can you get the exact error message? Is the driver modular?
> 
> The exact error message is:
> PCI: Found IRQ 12 for device 00:0a.0
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 00:0a.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xdc00. Vers LK1.1.17
> phy=0, phyx=24, mii_status=0xffff
> phy=1, phyx=0, mii_status=0xffff

That's just a rampant printk - no real problem.  The
3c59x update was, err, somewhat unexpected.  I've actually
asked Marcelo to back out to the 2.4.18 version because
there has been one report of a transceiver selection failure
with the 2.4.19-pre8 driver.

The thing's totally fragile, I'm afraid.  It supports 32 different
devices, of which I have five.  If you change anything, you break
something, and for some types of cards it takes months before
you hear about the breakage.


-
