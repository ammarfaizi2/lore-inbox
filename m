Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750768AbWFEIdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWFEIdY (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWFEIdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:33:24 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:20961 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750758AbWFEIdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:33:23 -0400
Date: Mon, 5 Jun 2006 10:33:21 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linville@tuxdriver.com,
        Denis Vlasenko <vda@ilport.com.ua>, acx100-devel@lists.sourceforge.net,
        acx100-users@lists.sourceforge.net
Subject: Re: wireless (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060605083321.GA15690@rhlx01.fht-esslingen.de>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605010636.GB17361@havoc.gtf.org> <20060604181515.8faa8fcf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604181515.8faa8fcf.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 04, 2006 at 06:15:15PM -0700, Andrew Morton wrote:
> On Sun, 4 Jun 2006 21:06:36 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> > >   It is about time we did something with this large and presumably useful
> > >   wireless driver.
> > 
> > I've never had technical objections to merging this, just AFAIK it had a
> > highly questionable origin, namely being reverse-engineered in a
> > non-clean-room environment that might leave Linux legally vulnerable.
> 
> I never knew that.
> 
> <reads changelog>
> <reads website>
> <reads wiki>
> 
> I still don't know that.  Denis, do you know the details?

The acx100 project was started by about 5 people examining the various
acx100 binary Linux driver "releases" for distro kernels around 2.4.18 etc.
Since this might fail to comply with usual "clean-room" practices
(e.g. one party examining a driver and then a separate party implementing
a new driver with the data gained from examining the original driver),
it may fail to be seen as acceptable for Linux inclusion.

Since missing kernel inclusion is both a maintenance overhead and
(most importantly!) a huge user-level issue, I'd see this as a big problem.

In case there are development-unrelated obstacles against kernel inclusion,
I see (at least?) two possibilities:

a) asking TI to sprinkle our driver effort with the (ahem) holy penguin pee
   required to have it blessed sufficiently for kernel inclusion (preferrably
   in combination with nice firmware blob licensing and specs for those
   chipsets would be nice)
   This might be a problem given that Theo de Raadt and many other people had
   fun repeatedly trying to contact TI for a useful statement concerning WLAN
   support.

b) abandoning our unfortunately not as blessed as intended (stability,
   community involvement, ...) big-effort driver efforts ("3 years and still
   going strong...") [1] and suggesting donating about 100000 OEM WLAN cards
   equipped with TI chipsets to various beautiful landfills in various
   countries ;-)

Whichever way this irons out, at this point I'm quite indifferent to what
happens, given that I really don't feel like spending too many endless weekends
with hardware and driver puzzles any more in exchange for rather dubious gains.
There's also a lot of fun in generic Linux kernel hacking, so...

Andreas Mohr

[1] we're *still* having issues with spotty ACK reception and radio
temperature drift recalibration on those unsupported chipsets,
which requires quite some focused development efforts and close examination
of WLAN traffic in order to really find out what the heck is going wrong here.
And please note that there's now the newer TNETW1450 chipset variant (most
prominently used by AVM hardware with its initial x86-only Linux USB2.0 driver)
with similar support issues which would require even more development.
