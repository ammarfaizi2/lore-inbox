Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263338AbTDCJyR>; Thu, 3 Apr 2003 04:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263339AbTDCJyR>; Thu, 3 Apr 2003 04:54:17 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:50660 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S263338AbTDCJyQ>;
	Thu, 3 Apr 2003 04:54:16 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Date: Thu, 3 Apr 2003 12:05:13 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, adaplas@pol.net
X-mailer: Pegasus Mail v3.50
Message-ID: <4A83DF6367@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Apr 03 at 9:40, Sven Luther wrote:
> On Thu, Apr 03, 2003 at 03:07:33AM +0100, Petr Vandrovec wrote:
> > On  2 Apr 03 at 22:55, James Simmons wrote:
> > 
> > > It doesn't need a struct pci_dev in this case. It is possible to get this 
> > > info from the i2c bus but I never seen any drivers do this. What data would
> > > we have to pass in get the EDID inforamtion? So the question is how 
> > > generic will get_EDID end up being or will we have to have driver specfic 
> > > hooks since I don't pitcure i2c approaches being the same for each video 
> > > card. Petr didn't you attempt this with the matrox driver at one time?
> > 
> > Yes, matroxfb provides one i2c (DDC) bus for each output videocard has.
> > I ended with only this support (and userspace EDID parser) as i2c was
> > initialized loong after framebuffer at that time... Now when i2c is usable
> > when fbdev initializes, it looks much better.
> > 
> > Only get_EDID interface I need is one which gets i2c bus as argument. But
> > I have no idea how I should handle situation where you have connected
> > two different monitors to both crtc1 outputs... Like 50Hz PAL TV &
> > 60+Hz VGA monitor. Currently it is user responsibility to resolve such
> > situation...
> 
> Is the EDID reading stuff not done per head ?

No. With matroxfb, you have two framebuffer devices, /dev/fb0 & /dev/fb1,
which can be connected to any of three outputs: analog primary, analog
secondary and DVI. Analog primary & DVI share same pair of DDC cables,
and analog secondary has its own... And user can interconnect fb* with
outputs in almost any way he wants, as long as hardware supports it.
                                                        Petr Vandrovec
                                                        

