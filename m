Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265047AbUFMLix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbUFMLix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 07:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbUFMLiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 07:38:52 -0400
Received: from tench.street-vision.com ([212.18.235.100]:63106 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S265047AbUFMLit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 07:38:49 -0400
From: Justin Cormack <justin@street-vision.com>
Message-Id: <200406131138.i5DBcfN11639@tench.street-vision.com>
Subject: Re: Serial ATA (SATA) on Linux status report (2.6.x mainstream  plan
To: leonw@mailcan.com (Leon Woestenberg)
Date: Sun, 13 Jun 2004 11:38:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40CC320F.2050500@mailcan.com> from "Leon Woestenberg" at Jun 13, 2004 12:53:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Justin Cormack wrote:
> > On Fri, 2004-06-11 at 03:30, Andre Tomt wrote:
> > 
> >>Since we're on the topic of new libata drivers, how is the Marvell 
> >>driver coming along? I'm getting several server units with a 4-port 
> >>version on-board in the not-so-distant future, it would be nice if they 
> >>could use all their drive bays ;-)
> > 
> We have those as well. (Supermicro P4SCT+ which have a rev 03 88sx8041
> part.)

I have the same chipset.
 
> > 
> > Though not as useful as a libata driver (and not GPL, though the license
> > is entirely unrestrictive), there is an open source driver for the
> > Marvell chipsets:
> > 
> > http://www.highpoint-tech.com/BIOS%20%2B%20Driver/rr1820a/Linux/rr182x-openbuild-v1.02.tgz
> > 
> > It wont build on 2.6 due to cli/sti (v. easy to fix though - its just
> > the irq locking), and it only supports 8 channel chips (only a few
> > #defines for PCI ids and number of ports). Intend to fix it up and test
> > it next week if the libata driver not out, as I have a few of these. The
> > highpoint card is the first PCI-X SATA card I have actually managed to
> > get hold of, but unlike other highpoint cards is not their chipset:
> > 
> > 03:02.0 SCSI storage controller: Marvell MV88SX5081 8-port SATA I PCI-X
> > Controller (rev 03)
> > 
> I have a totally different set of source code files for the 
> MV88SX50[4|8][0|1] chips, also open-source from Marvell (although I have
> to check the exact license).

ah. Can you check the license in detail? See if it is distributable and
modifiable?
 
> Looking at the Highpoint source code, they seem to have taken some of 
> the Marvell source code (mv*.*) and adapted it for their RAID system.

I was intending to strip out the raid stuff anyway, as the highpoint stuff is
binary and of no interest to me.
 
> I am interested in doing some maintenance work on the Marvell driver,
> which indeed mostly needs attention to proper locking. Also, it did
> not yet support the rev 03 hardware when I downloaded it.

The highpoint one does. It would be useful to diff the shared bits.
 
> I found the driver source on ftp://ftp.supermicro.com, but it seems to
> have been removed lately. Supermicro forwards me to Adaptec who writes
> the BIOS raid system (ugh).

Ah I never saw this. In their faq supermicro say there is only binary linux
support.
 
I have some time next week to look at this. If nothing else it would give
a reference for checking a libata driver. Can you check the license on your
files and see if you can send them.

Justin
