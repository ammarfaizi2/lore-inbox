Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135645AbRD2LFG>; Sun, 29 Apr 2001 07:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135696AbRD2LE4>; Sun, 29 Apr 2001 07:04:56 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:30156 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135645AbRD2LEl>; Sun, 29 Apr 2001 07:04:41 -0400
Date: Sun, 29 Apr 2001 13:04:32 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Michael F Gordon <Michael.Gordon@ee.ed.ac.uk>
Cc: David Lang <david.lang@digitalinsight.com>,
        Garett Spencley <gspen@home.com>, linux-kernel@vger.kernel.org,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 2.4.4 breaks dhcpcd with Realtek 8139
Message-ID: <20010429130432.I679@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.30.0104281142520.3423-100000@localhost.localdomain> <Pine.LNX.4.33.0104281126570.16046-100000@dlang.diginsite.com> <20010428231151.A11841@ee.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010428231151.A11841@ee.ed.ac.uk>; from Michael.Gordon@ee.ed.ac.uk on Sat, Apr 28, 2001 at 11:11:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 11:11:51PM +0100, Michael F Gordon wrote:
> On Sat, Apr 28, 2001 at 11:29:15AM -0700, David Lang wrote:
> > what sort of switch are you plugged into? some Cisco switches have a
> > 'feature' that ignores all traffic from a port for X seconds after a
> > machine is plugged in / powered on on a port (they claim somehting about
> > preventing loops) it may be that the new kernel now boots up faster then
> > the old one so that the DHCP request is lost in the switch, a few seconds
> > later when you do it by hand the swich has enabled your port and
> > everything works.
> 
> I'm plugged in to a cable modem, with the DHCP server at the ISP.  The
> server requires the MAC address to be registered, so sending the DHCP
> request with a different MAC address could cause the symptoms.  I doubt
> it's a timing problem - replacing the 8139 driver with the 2.4.3 version
> but otherwise using the distributed 2.4.4 makes DHCP work as expected.

The Windows drivers distributed along with that Realtek cards
have this problem[1] any many users of the CSN[2] run into the
"secure mode" on our hubs/switches, causing their port to be
disabled.

So we have just ported a BUG from Windows to Linux, if you are
right ;-)

BTW: CC'ed the maintainer. He might be interested, as maintainers
   usally are on BUGs ;-)

Regards

Ingo Oeser

[1] Sometimes forgetting their MAC and sending either random or
   zero MAC out. This depends on whatever.

[2] Chemnitz Students Network - large LAN with >1000 computers
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
