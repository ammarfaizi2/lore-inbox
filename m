Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276720AbRJHAcf>; Sun, 7 Oct 2001 20:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276721AbRJHAc0>; Sun, 7 Oct 2001 20:32:26 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24060
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S276720AbRJHAcN>; Sun, 7 Oct 2001 20:32:13 -0400
Date: Sun, 7 Oct 2001 17:32:37 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Riley Williams <rhw@MemAlpha.CX>
Cc: David =?unknown-8bit?Q?G=F3mez?= <davidge@jazzfree.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA errors [was: Some ext2 errors]
Message-ID: <20011007173237.A30930@mikef-linux.matchmail.com>
Mail-Followup-To: Riley Williams <rhw@MemAlpha.CX>,
	David =?unknown-8bit?Q?G=F3mez?= <davidge@jazzfree.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011007110212.A22412@mikef-linux.matchmail.com> <Pine.LNX.4.33.0110072325330.6632-100000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110072325330.6632-100000@infradead.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 11:39:04PM +0100, Riley Williams wrote:
> Hi Mike.
>

Hey Riley,

>  >>> As far as I can tell, it's a problem with the PSU in the computer
>  >>> in question, as I can swap ANYTHING else in there, motherboard
>  >>> included, without the problem going away on that drive, but as
>  >>> soon as I swap the PSU, the problems vanish - even if I put a PSU
>  >>> with a lower rating in its place.
> 
>  > It may not be your MB or drive, but an interaction between them.
>  > I.E. Your bios could've told the linux driver to use a higher
>  > dma level than the drive likes.
> 
> Always possible, but I'd consider it unlikely that using the SAME
> motherboard and drive, but with a different PSU would have any affect
> whatsoever if such was the reason.
> 
> I would presume that the old PSU was just too noisy for that
> particular drive, and a new PSU is rather quieter in that regard.
>

But we don't know what is happening with David's system.

To rule out some possible causes David, you should run these tests:
memtest86 (www.memtest86.org
badblocks -s /dev/hda (read only hard drive test, newer versions have a -p
option for safe write mode tests too)

>  > Try running "hdparm -d0 /dev/hda" (since your drive is hda in
>  > this case...) And see if the problem goes away. If it does, then
>  > try Multimode dma, if (-X34) you get errors, try single mode
>  > (probably -X31), if you get no errors there, try UDMA mode 2
>  > (-X66, also make sure you have a 80 line ide cable) and see if
>  > any of the problems come back.
> 
> Unfortunately, none of that is relevant in my case...see below...
>

But maybe for david...  David, try the tests above with read only badblocks...

>  >>>> Yeah. If you can't figure out hdparm, leave it alone.
> 
>  >>> Who says hdparm has anything to do with it?
> 
>  >> He says, it seems he has very deep knowledge of hdparm 'secrets'.
> 
>  > Again, sorry for being presumptuous. I've only been able to cause
>  > this with hdparm. Maybe I'm just not using new enough hardware...
> 
> The system in question is my network printserver, which has a 386sx/16
> processor and a very definitely 40 line cable with no support for
> anything else. The hard drive is an antique Maxtor 800M one, and I
> have no problem assuring you that it's not possible to buy that model
> new, and hasn't been for some years now...
>

It would probably recognize a 2gb drive, which you could easily raid 1 for
your server, assuming that there are two ide connectors on that old 386 MB.

This just adds another possible test...  Buying a new power supply.

David, let us know what you find...

Mike

> Best wishes from Riley.
> 
