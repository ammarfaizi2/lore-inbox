Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273829AbRIXIfv>; Mon, 24 Sep 2001 04:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273827AbRIXIfb>; Mon, 24 Sep 2001 04:35:31 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:24331 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S273829AbRIXIfU>; Mon, 24 Sep 2001 04:35:20 -0400
Date: Mon, 24 Sep 2001 10:35:44 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Grant <davidgrant79@hotmail.com>
Cc: Greg Ward <gward@python.net>, bugs@linux-ide.org,
        linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Message-ID: <20010924103544.A1572@suse.cz>
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz> <20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca> <20010921215622.A1282@suse.cz> <20010921164304.A545@gerg.ca> <20010922100451.A2229@suse.cz> <OE3183UV8wAddX47sFo00001649@hotmail.com> <20010922110945.B678@gerg.ca> <OE48GTjkifTNRMOKS310000192c@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OE48GTjkifTNRMOKS310000192c@hotmail.com>; from davidgrant79@hotmail.com on Sat, Sep 22, 2001 at 01:07:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 01:07:39PM -0700, David Grant wrote:
> >
> > BTW, you wouldn't happen to know which kernel version was in the Linux
> > distros you attempted to install, would you?  Not that it
> > matters... 2.4.9 doesn't work for me, and I haven't heard anyone telling
> > me to upgrade to the latest bleeding edge 2.4.10.preXX or 2.4.9acYY.
> 
> Redhat 7.1 uses 2.4.2-2 (redhat version).  Debian uses 2.2.19-pre17?
> something weird like that.  Mandrake uses 2.4.8 (which I now believe had no
> changes to VIA and/or Promise code).  I'm still wondering when Alan Cox's
> fixes went into the Linus code.  And I'm still trying to figure out why
> Alan's code is called via82cxxx, while Vojtech's is called vt82cxxx.  So
> either someone renamed Alan's version back to vt82cxxx to integrate into the
> main kernel tree, or it never got included???  But I know Vojtech's recent
> fixes are still in the latest pre (2.4.10-pre1 I think).

It's only via82cxxx, and is in quite recent versions in both the latest
Alan's and Linus's kernels ... 

> So from what you are saying and what I'm saying, 2.4.8 and 2.4.9 don't work.
> 2.4.9 should have included Alan's fixes since he originally patched them to
> 2.4.6-ac5.  So his fixes don't seem to fix OUR problem.  The only hope left
> might be Vojtech's changes, which are in 2.4.10-pre1.  But I doubt that
> these are major changes, or else, like you say, someone would have told us
> to upgrade to that kernel.

No, they only affected 686b's and newer chips.

> I actually just had an idea which just came to me.  I have added a little
> bit of hardware since I first started playing with Linux.  I added a network
> card.  This could have been around the time that I started having trouble
> installed Linux period.  And I also remember my BIOS warning me as I started
> my computer, "The PCI device you just added will be sharing an IRQ with
> 'Promise IDE Controller'.  You must alter the BIOS settings manually if
> these devices don't support IRQ sharing."  So, I could see how that could
> cause my Promise to not work properly, but the VIA too?  I'm haven't done
> any looking into the IRQ for the Southbridge any whether there is any
> sharing.  I also added a USB webcam, but I don't think that will do
> anything.
> 
> Also, if someone could explain to me personally over e-mail how Linux
> handle's IRQs and stuff, that would be nice.  Specifically, I'm wondering
> about something I read in the Mandrake installer guide.  It said that I
> should change the BIOS setting: "Plug & Play Computer" to "No".  I currently
> have had it set to "Yes," and this is what I used when I tried to install
> Redhat and it used to work.  I'm just confused as to what exactly this BIOS
> setting does.

The PnP stuff is for ISA PnP cards. If you don't have those, it's
irrelevant. When "PnP OS Installed" is set to "No", the BIOS does the
ISAPnP initialization. If it is set to "Yes", it skips that step. Linux
prefers to have the ISAPnP cards pre-initialized, though it can do it
all by itself.

-- 
Vojtech Pavlik
SuSE Labs
