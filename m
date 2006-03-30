Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWC3LxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWC3LxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWC3LxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:53:23 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:21712 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751134AbWC3LxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:53:22 -0500
Date: Thu, 30 Mar 2006 13:53:15 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: OGAWA Hirofum <hirofumi@mail.parknet.co.jp>
Cc: Con Kolivas <kernel@kolivas.org>, john stultz <johnstul@us.ibm.com>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PM-Timer: doesn't use workaround if chipset is not buggy
Message-ID: <20060330115315.GA15375@rhlx01.fht-esslingen.de>
References: <20060320122449.GA29718@outpost.ds9a.nl> <1142968999.4281.4.camel@leatherman> <8764m7xzqg.fsf@duaron.myhome.or.jp> <200603221121.16168.kernel@kolivas.org> <87hd5qmi1d.fsf_-_@duaron.myhome.or.jp> <20060323170413.GA20234@rhlx01.fht-esslingen.de> <871wwtja30.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871wwtja30.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 24, 2006 at 03:21:39AM +0900, OGAWA Hirofumi wrote:
> Andreas Mohr <andi@rhlx01.fht-esslingen.de> writes:
> 
> > Should I do a public request for chipset testing?
> > (I wrote a small test app here that would hopefully identify a buggy
> > chipset).
> 
> I think almost ICH4 is not buggy.  But probably current approach is safe.
> So, I added "pmtmr_good" to disable the workaround instead.
> 
> I posted probably similar one for mainly ICH4 users.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114297656924494&w=2

IMHO this request was much too non-verbose (both Subject *and* introduction).
Interested parties wouldn't even know that they should be interested in it ;)


> > Data that I have collected from internet snippets (mostly Intel errata
> > documents):
> > Affected (PCI ID / rev):
> >   - ICH4???
> >   - PIIX4 A0 (0x7113 / 00?), A1 (0x7113 / 00?), B0 (0x7113 / 01?)
> >   - PIIX4E A0 (0x7113 / 02?)
> > Probably fixed (PCI ID / rev):
> >   - PIIX4M A0 (0x7113 / 03?)
> >
> > My Toshiba Satellite 4280 seems to have non-buggy PIIX4M
> > (since it's PCI rev. 03), haven't had time to test reliability yet, though.
> 
> I tested PIIX4E (yes, really buggy), ICH7, VT88237. And ICH6 was
> reported as sane.

What further steps should now be taken for this patch to be included
in a sufficiently official kernel in some form?

I'm asking now since as some kind of weird Christmas present this one
has found its way under my desk rather very accidentally:

00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge (rev 0
3)
00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
00:06.0 SCSI storage controller: Adaptec AIC-7880U
00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 7
4)
00:0c.0 VGA compatible controller: ATI Technologies Inc 264VT4 [Mach64 VT4] (re
v 3a)


So this means I have ICH5, PIIX4M and PIIX4 rev. 01 (most likely buggy)
and some non-Intel chipsets. Ideal conditions for testing.

Andreas Mohr
