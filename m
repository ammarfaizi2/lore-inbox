Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRIVULA>; Sat, 22 Sep 2001 16:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272062AbRIVUKu>; Sat, 22 Sep 2001 16:10:50 -0400
Received: from oe48.law11.hotmail.com ([64.4.16.20]:50962 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S272038AbRIVUKg>;
	Sat, 22 Sep 2001 16:10:36 -0400
X-Originating-IP: [64.180.168.53]
From: "David Grant" <davidgrant79@hotmail.com>
To: "Greg Ward" <gward@python.net>
Cc: <bugs@linux-ide.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz> <20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca> <20010921215622.A1282@suse.cz> <20010921164304.A545@gerg.ca> <20010922100451.A2229@suse.cz> <OE3183UV8wAddX47sFo00001649@hotmail.com> <20010922110945.B678@gerg.ca>
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Date: Sat, 22 Sep 2001 13:07:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <OE48GTjkifTNRMOKS310000192c@hotmail.com>
X-OriginalArrivalTime: 22 Sep 2001 20:10:56.0694 (UTC) FILETIME=[B06F6D60:01C143A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> BTW, you wouldn't happen to know which kernel version was in the Linux
> distros you attempted to install, would you?  Not that it
> matters... 2.4.9 doesn't work for me, and I haven't heard anyone telling
> me to upgrade to the latest bleeding edge 2.4.10.preXX or 2.4.9acYY.

Redhat 7.1 uses 2.4.2-2 (redhat version).  Debian uses 2.2.19-pre17?
something weird like that.  Mandrake uses 2.4.8 (which I now believe had no
changes to VIA and/or Promise code).  I'm still wondering when Alan Cox's
fixes went into the Linus code.  And I'm still trying to figure out why
Alan's code is called via82cxxx, while Vojtech's is called vt82cxxx.  So
either someone renamed Alan's version back to vt82cxxx to integrate into the
main kernel tree, or it never got included???  But I know Vojtech's recent
fixes are still in the latest pre (2.4.10-pre1 I think).

So from what you are saying and what I'm saying, 2.4.8 and 2.4.9 don't work.
2.4.9 should have included Alan's fixes since he originally patched them to
2.4.6-ac5.  So his fixes don't seem to fix OUR problem.  The only hope left
might be Vojtech's changes, which are in 2.4.10-pre1.  But I doubt that
these are major changes, or else, like you say, someone would have told us
to upgrade to that kernel.

> > [...] no version of Linux will
> > install.  After the installer starts to install a few packages
(sometimes
> > 10, sometimes 100), the installer halts, the hard disk light stays on,
and
> > if I use CTRL-ALT-F4, I see these DMA timeout errors.  The hard drive is
> > unresponsive unless I do a cold boot, as opossed to warm boot.
>
> That sounds like problems I saw in the linux-kernel archive from a few
> months back: intermittent, not-always-there, takes-a-while-to-manifest
> DMA timeouts.  The DMA timeout I'm experiencing is always there, 100%
> reliable, and manifests with the first attempt to read a sector from the
> disk (the hunt for partitions).

The time that I got Linux installed (not sure how I got it installed without
a DMA timeout, probably just a fluke), it used to fail every time I booted.
Well it booted the first time, crashed a few minutes later, and then every
time I booted after that it halted while tring to fschk and repair the disk
since it was unmounted when it crashed the first time.  So I did have some
consistency there like you.

> For the record, I'm starting to suspect either a bad cable or a bad
> drive.  I've had positive reports from two people with the ASUS A7V
> motherboard and ATA/100 drives under Linux 2.4, so it's certainly
> possible.  I just need to find someone with some redundant hardware that
> I can play with.

I actually just had an idea which just came to me.  I have added a little
bit of hardware since I first started playing with Linux.  I added a network
card.  This could have been around the time that I started having trouble
installed Linux period.  And I also remember my BIOS warning me as I started
my computer, "The PCI device you just added will be sharing an IRQ with
'Promise IDE Controller'.  You must alter the BIOS settings manually if
these devices don't support IRQ sharing."  So, I could see how that could
cause my Promise to not work properly, but the VIA too?  I'm haven't done
any looking into the IRQ for the Southbridge any whether there is any
sharing.  I also added a USB webcam, but I don't think that will do
anything.

Also, if someone could explain to me personally over e-mail how Linux
handle's IRQs and stuff, that would be nice.  Specifically, I'm wondering
about something I read in the Mandrake installer guide.  It said that I
should change the BIOS setting: "Plug & Play Computer" to "No".  I currently
have had it set to "Yes," and this is what I used when I tried to install
Redhat and it used to work.  I'm just confused as to what exactly this BIOS
setting does.

Thanks,

David Grant
