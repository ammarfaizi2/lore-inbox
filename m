Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTI0VVd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 17:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbTI0VVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 17:21:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22404 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262217AbTI0VVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 17:21:31 -0400
Date: Sat, 27 Sep 2003 23:21:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>, akpm@osdl.org,
       petero2@telia.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Message-ID: <20030927212116.GA18445@ucw.cz>
References: <10645086121286@twilight.ucw.cz> <200309251323.33416.dtor_core@ameritech.net> <20030925223032.GA32130@ucw.cz> <200309260224.54264.dtor_core@ameritech.net> <20030926075408.GA7330@ucw.cz> <20030927201951.GA401@elf.ucw.cz> <20030927210504.GA18178@ucw.cz> <20030927210948.GA360@elf.ucw.cz> <20030927211606.GA18264@ucw.cz> <20030927211838.GC360@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030927211838.GC360@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 11:18:38PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > > One thing I tried to avoid is a 'device class' kind of field, that'd
> > > > > > tell if a device is a mouse a touchpad, touchscreen, tablet, whatever.
> > > > > > I tried to avoid it because there are devices that don't fall into any
> > > > > > predefined class and if we make enough classes, someone someday will
> > > > > > make a device that won't fit again.
> > > > > 
> > > > > I believe having "is overlaid over screen" bit gets it right :-).
> > > > 
> > > > Tablets aren't. And they're handled the same way as touchscreens.
> > > 
> > > Ouch, so what's the difference between tablet and touchpad? Is it only
> > > in a way you are expected to use it? In such case "this is touchpad"
> > > bit is probably needed :-(.
> > 
> > For a tablet, the cursor follows the pen movement all the time. For a
> > touchpad, if you lift the finger and place it elsewhere, nothing
> > happens. This way you can move the cursor further by repeatedly stroking
> > the pad.
> 
> But difference is only in software, right? You could use synaptics as
> a tablet, its just little small. So perhaps "this is touchpad" bit is
> needed.

Yes, exactly so. We may have similar problems with differentiation
elsewhere (touchpad vs 6dof device), so we'll probably need the 'class'
field.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
