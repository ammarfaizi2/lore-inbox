Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSHHIeD>; Thu, 8 Aug 2002 04:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSHHIeD>; Thu, 8 Aug 2002 04:34:03 -0400
Received: from mail-fe71.tele2.ee ([212.107.32.235]:15517 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S317387AbSHHIeB> convert rfc822-to-8bit;
	Thu, 8 Aug 2002 04:34:01 -0400
Date: Thu, 8 Aug 2002 10:37:38 +0200
Message-Id: <200208080837.g788bcM01508@eday-fe6.tele2.ee>
From: "Thomas Munck Steenholdt" <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
To: dledford@redhat.com
Subject: Re: i810 sound broken...
MIME-Version: 1.0
X-EdMessageId: 27081b071b5340154b445440575658571d57545f10551f5d5959541d104a52525071
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 05, 2002 at 08:38:52PM +0200, Thomas Munck Steenholdt wrote:
> > On Mon, 2002-08-05 at 17:28, Alan Cox wrote:
> > > On Mon, 2002-08-05 at 14:47, venom@sns.it wrote:
> > > > Still OSS modules for i810 does not work with 2.5 kernels, actually 2.4
> > > > is fine. No time to switch to alsa (and not interested for now too). 
> > > 
> > > OSS for 2.5 is someone elses problem. I have no plan to do any work on
> > > the old OSS drivers for the 2.5 tree or even to submit 2.4 updates into
> > > 2.5 for it. 
> > > 
> > 
> > So anyway - How should I go about determining the exact problem on my
> > box... I've had it all along, and I know for a fact that the hardware is
> > OK... Modules are loaded correctly, but it just does not work!
> 
> I'll tell you what you can do.  Grab some ICH docs so you have a list of 
> the valid regs on the i810 sound chip.  Then, go into i810_audio.c and 
> write me up a little hack that, at the end of the chip init sequence, 
> whill dump the state of all the regs on the chip.  Make it smart enough to 
> know about different regs on different chips (aka, Intel ICH0 and ICH1 
> will probably have a slightly different reg setup than the ICH2 and 
> later).  Then, load that driver on your machine and get me that register 
> dump.  Then, I'll take the patch and apply it here on the i810 machines I 
> have that do work and get their register dump.  We'll see then where the 
> differences are.  On the i845 based machine I have at work, where the 
> sound doesn't work just like you describe, I've isolated the problem down 
> to the fact that when we start the DMA engine it *immediately* signals 
> that it has already finished the DMA process and has already stopped again 
> but it never actually does the DMA.  So, I suspect there is some config 
> bit somewhere set wrong and the DMA is not taking place as a result (hell, 
> for all I know, the AC97 link for sound output may be off or something 
> like that).  Getting a register dump from several busted machines as well 
> as from some working machines should enable me to solve the problem 
> relatively easily.  I just haven't had the time to write the patch myself 
> and do any more work on the thing :-(

Please excuse me for not immediately responding with a working hack for this.
I'm sorry to say that I have not yet had any experience in kernel programming
and even though I jumped on the "job" as soon as I saw you mail, I quickly
realized that I probably need some time of practicing, figuring out how stuff
is done, and get into the actual close-to-hardware programming that is
required for stuff like this... 

Instead of promising to have a hack ready at any time... I'll follow this
case closely and see what I can learn from it. I need to get
into how stuff is done in this kind of area.
Hopefully some day you'll see meactually post a patch of some
kind... ;-)

Back to the case... I realized that I might not have explained myself
correctly regarding my hardware...
My machine is i845 based, using the i810 driver for audio...
it is not i810 based!

Thomas


-- Send gratis SMS og brug gratis e-mail på Everyday.com -- 

