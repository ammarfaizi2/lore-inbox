Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275599AbTHOAqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275601AbTHOAqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:46:52 -0400
Received: from h68-147-156-215.cg.shawcable.net ([68.147.156.215]:4226 "EHLO
	tooleweb.homelinux.com") by vger.kernel.org with ESMTP
	id S275599AbTHOAqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:46:50 -0400
Message-ID: <3F3C2DA0.1030504@tooleweb.homelinux.com>
Date: Thu, 14 Aug 2003 18:47:28 -0600
From: Robert Toole <tooler@tooleweb.homelinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Jonathan Morton <chromi@chromatix.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: agpgart failure on KT400
References: <779ACC8A-CE86-11D7-A88B-003065664B7C@chromatix.demon.co.uk> <20030814184741.GA10901@redhat.com>
In-Reply-To: <20030814184741.GA10901@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Thu, Aug 14, 2003 at 07:38:15PM +0100, Jonathan Morton wrote:
>  > I recently upgraded to a m/board using the KT400 chipset - specifically 
>  > an Abit KD7-G - and now find that I can't load agpgart.  The relevant 
>  > kernel messages:
>  > 
>  > agpgart: Maximum main memory to use for agp memory: 941M
>  > agpgart: Detected Via Apollo Pro KT400 chipset
>  > agpgart: unable to determine aperture size.
>  > 
>  > This results in my inability to load XFree86, using the proprietary ATI 
>  > drivers, which appear to require AGP support.  Note that the same 
>  > problem appears using ATI's "internal agpgart module", just to show I 
>  > know the difference.  The regular XFree86 drivers probably work without 
>  > AGP - I haven't bothered trying yet.
>  > 
>  > NB: I tried sending this to Jeff Hartmann, but his address at 
>  > precisioninsight.com is dead.  Please CC me, I'm not subscribed to the 
>  > list.  Better still, refer me to someone who actually knows what to do 
>  > about it.
>  > 
>  > The BIOS is set up for either a 256MB or 64MB AGP aperture - whichever 
>  > of the two settings makes no difference.  The video card is a Radeon 
>  > 9700 Pro, 128MB.  The kernel configuration includes ACPI and 
>  > HIGHMEM-4GB support, if that is at all relevant.
>  > 
>  > This problem is identically present in 2.4.21 and 2.4.22-rc2.
> 
> For 2.4, you're stuck. It needs AGP3 support. The KT400 stuff in
> 2.4 only works if you shove an AGP2.x gfx card in the slot.
> As soon as you put a 3.x capable card in there the chipset changes
> mode, and as there's no AGP3 support in 2.4 yet, you're pooched.
> 
> The code in 2.6test should work, but before you (or anyone else) asks,
> no, it won't work without a bit of bending in 2.4, and I don't have
> a backport, or plans to do so any time soon.
> 
> Sorry,
> 
> 		Dave
> 
Dave,

I'd like to apologise in advance if I seem too pushy, and I know you all 
have more than enough to do:

But this seems to be a pretty big thing to leave out of the production 
Kernel. Unless Red Hat and other distros are planning to use 2.6 in 
their next release, there are a lot of these KT400 MBs out there. My 
local computer reseller was selling 10 to 20 of these boards for every 
one of any other AMD chipset right up until VIA released the KT600.

I am actually using the KT-400-A variant of this board, which has no 
option to use anything but agp 3.0 even with a 4X card. (straight from 
the mouths of Giga-byte tech support)

Yes, I could use 2.6-x and help test that, but like so many people, I 
need to have something reliable so I can get some work done.

If I knew anything at all about writing code, I would be more than happy 
to help, but since I don't, I'd like to offer my time to help test any 
patches or backports someone could come up with.

Thanks,

-- 
Robert Toole
tooler@tooleweb.homelinux.com

