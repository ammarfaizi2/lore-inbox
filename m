Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSGCADt>; Tue, 2 Jul 2002 20:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSGCADs>; Tue, 2 Jul 2002 20:03:48 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:22666 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314149AbSGCADs>;
	Tue, 2 Jul 2002 20:03:48 -0400
Date: Wed, 3 Jul 2002 02:06:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: Anton Altaparmakov <aia21@cantab.net>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
Message-ID: <20020703020607.A7689@ucw.cz>
References: <aia21@cantab.net> <200207011746.g61Hkxf27019@blake.inputplus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207011746.g61Hkxf27019@blake.inputplus.co.uk>; from ralph@inputplus.co.uk on Mon, Jul 01, 2002 at 06:46:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 06:46:58PM +0100, Ralph Corderoy wrote:
> 
> Hi Anton,
> 
> > > What I'd like to see, if both hid.o and usbkbd.o can handle a
> > > keyboard, is that hid.o gets the job.  Then usbkbd.o can stay in
> > > config.in and be built just in case it's needed.
> > 
> > usbkbd.o is never needed when hid.o is present unless I have
> > misunderstood something.
> 
> Ah, I thought that in the same way the BIOS might not support the HID
> interface and so can use the simpler Boot interface, a keyboard might
> not implement the HID interface and just implement the simpler Boot one.
> Apologies if this isn't the case.  I agree that hid.o should be able to
> cope with everything then.

No, this is not the case. Even if the device implements only one mode
and that mode is HIDBP compatible, it's still also HID compatible,
because HIDBP is a subset of HID.

> > > Ah, OK, thanks.  Unfortunately, I've already moved onto 2.4.18 built
> > > from source due to some of my other needs.
> > 
> > In that case just reconfigure your kernel not to include usbkbd and
> > use hid instead, recompile, and be happy.
> 
> Yes, that's what I've done, and I'm happy, but still wish to persue the
> problem in order that usbkbd.o gets fixed.  Otherwise, someone else will
> spend their weekend learning about usbkbd.c, HID, Boot, etc.  :-)

usbkbd.c will get fixed. No worries.

-- 
Vojtech Pavlik
SuSE Labs
