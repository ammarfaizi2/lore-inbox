Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276522AbRJGSCV>; Sun, 7 Oct 2001 14:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276519AbRJGSCM>; Sun, 7 Oct 2001 14:02:12 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48121
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S276522AbRJGSBz>; Sun, 7 Oct 2001 14:01:55 -0400
Date: Sun, 7 Oct 2001 11:02:12 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: David =?unknown-8bit?Q?G=F3mez?= <davidge@jazzfree.com>
Cc: Riley Williams <rhw@MemAlpha.CX>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: IDE DMA errors [was: Some ext2 errors]
Message-ID: <20011007110212.A22412@mikef-linux.matchmail.com>
Mail-Followup-To: David =?unknown-8bit?Q?G=F3mez?= <davidge@jazzfree.com>,
	Riley Williams <rhw@MemAlpha.CX>,
	Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110062358590.25149-100000@infradead.org> <Pine.LNX.4.33.0110071510190.878-100000@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110071510190.878-100000@fargo>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 03:15:33PM +0200, David G?mez wrote:
> On Sun, 7 Oct 2001, Riley Williams wrote:
> 
> > I see this regularly on one of my systems, and hdparm has never even
> > been insatalled on that system. If I put the drive in a different
> > system, the drive reports clean, but whatever drive I put in here
> > regularly reports that problem.
> 
> Yes, i also have seen this error also when not using hdparm, so it's not
> the cause of this ext2 errors.
>

Oh, sorry, I blamed before I had facts... my bad.

> >
> > As far as I can tell, it's a problem with the PSU in the computer in
> > question, as I can swap ANYTHING else in there, motherboard included,
> > without the problem going away on that drive, but as soon as I swap
> > the PSU, the problems vanish - even if I put a PSU with a lower rating
> > in its place.
> 
> If i see this error show more times i'll try to replace the PSU. First i
> think is has some relation with my VIA chipset, but if you tell me you
> have changed even your motherboard... ;)
>

It may not be your MB or drive, but an interaction between them.

I.E. Your bios could've told the linux driver to use a higher dma level than
the drive likes.

Try running "hdparm -d0 /dev/hda" (since your drive is hda in this case...)

And see if the problem goes away.  If it does, then try Multimode dma, if
(-X34)
you get errors, try single mode (probably -X31), if you get no errors there,
try UDMA mode 2 (-X66, also make sure you have a 80 line ide cable) and see
if any of the problems come back. 

> >  > Yeah.  If you can't figure out hdparm, leave it alone.
> >
> > Who says hdparm has anything to do with it?
> 
> He says, it seems he has very deep knowledge of hdparm 'secrets'.
> 

Again, sorry for being presumptuous.  I've only been able to cause this with
hdparm.  Maybe I'm just not using new enough hardware...

Mike
