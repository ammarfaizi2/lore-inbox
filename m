Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUAJTmK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUAJTli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:41:38 -0500
Received: from doortje.mesa.nl ([80.126.82.97]:50447 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id S265359AbUAJTkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:40:47 -0500
Date: Sat, 10 Jan 2004 20:40:40 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, vojtech@suse.cz
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040110194040.GA24318@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
References: <20040110175930.GA1749@elf.ucw.cz> <200401101428.49358.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401101428.49358.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 02:28:49PM -0500, Dmitry Torokhov wrote:
> On Saturday 10 January 2004 12:59 pm, Pavel Machek wrote:
> > ..aka "make synaptics touchpad usable in 2.6.1" -- synaptics support
> > is not really suitable to be enabled by default. You can not click by
> > tapping the touchpad (well, unless you have very new X with right
> > configuration, but than you can't go back to 2.4),
> 
> It is my understanding that by setting "Protocol" to "auto-dev" and
> "Device" to "/dev/psaux" you can freely switch between 2.4 and 2.5.

I work with this setting for a couple of weeks now switching between 2.4
and 2.6. The touchpad works quite well in X. (Dell inspiron 8000).
I only notice I have to tap harder to get a click.

-Marcel

> 
> >                                                    and touchpad senses
> > your finger even when it is not touching, doing spurious movements =>
> > you can't hit anything on screen. 
> 
> Does the touchpad sensitivity is OK for you when using then native XFree
> driver? Should we bump it up a little?
> 
> Plus, there were issues in mousedev regarding PS2 emulation for touchpads
> in absolute mode, it should be fixed in -mm or you can try grabbing patches
> from http://www.geocities.com/dt_or/input/2_6_1/
> You are probably mostly interesed in one that deals with mouse jitter.
> 
> >                                    Without synaptics extensions
> > everything works just fine. You can reenable synaptics support using
> > commandline.
> >
> > Plus it documents psmouse_noext option.
> >
> 
> Why would you document something that is deprecated? It was removed so the
> new users would not start using it instead of psmouse.proto. psmouse.noext
> should be gone soon.
> 
> Plus, you not only disabling Synaptics extensions but Genius and Logitech's
> ones as well.
> 
> > Please apply,
> > 								Pavel
> 
> Dmitry
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
