Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUJAS0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUJAS0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUJAS0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:26:36 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:42112 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S265971AbUJAS0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:26:22 -0400
Date: Fri, 1 Oct 2004 20:26:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Message-ID: <20041001182602.GA1613@ucw.cz>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <1096586774l.5206l.1l@werewolf.able.es> <20040930170505.6536197c.akpm@osdl.org> <200410010030.39826.dtor_core@ameritech.net> <20041001180101.GC14015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001180101.GC14015@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 11:01:01AM -0700, Greg KH wrote:
> On Fri, Oct 01, 2004 at 12:30:39AM -0500, Dmitry Torokhov wrote:
> > On Thursday 30 September 2004 07:05 pm, Andrew Morton wrote:
> > > > One other question. Isn't /dev/input/mice supposed to be a multiplexor
> > > > for mice ? I think I remember some time when I could have both a PS2 and
> > > > a USB mouse connected and X pointer followed both. Now if I boot with the
> > > > USB mouse plugged, the PS2 one does not work. If I boot with usb unplugged
> > > > and plug it after boot, both work; usb mouse works fine, and PS2 just
> > > > jumps half screen each time I move it, and with big delays.
> > > > 
> > > 
> > 
> > I bet it's USB legacy emulation topic again. Try loading USB modules first
> > and then psmouse, should help.
> > 
> > Vojtech, what is the status of USB handoff patches. I have seen several
> > variants and so far heard only success stories from people using them. Can
> > we have them in kernel proper?
> 
> They are already in the -mm tree, but they need to be explicitly enabled
> with a boot command line option to have the handoff happen.
 
I think we really need them by default. I had seven bugs with touchpads,
lost synchronization with PS/2 mice and similar fixed just by enabling
this patch unconditionally in the SuSE tree.

As far as I know, there are only a few nForce boards where enabling the
patch hurts - we should be able to do a DMI exception for those. Anyway,
those boards have bigger problems, as USB reportedly doesn't work there
(because the USB drivers do the same handoff).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
