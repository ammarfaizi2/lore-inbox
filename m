Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266119AbUBQGSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbUBQGSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:18:20 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:32336 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266119AbUBQGSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:18:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Tue, 17 Feb 2004 01:18:05 -0500
User-Agent: KMail/1.6
Cc: Emmeran Seehuber <rototor@rototor.de>, linux-kernel@vger.kernel.org
References: <200402112344.23378.rototor@rototor.de> <200402161334.43583.rototor@rototor.de> <20040216143617.GA959@ucw.cz>
In-Reply-To: <20040216143617.GA959@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402170118.05753.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 February 2004 09:36 am, Vojtech Pavlik wrote:
> On Mon, Feb 16, 2004 at 01:34:43PM +0000, Emmeran Seehuber wrote:
> 
> > On Sunday 15 February 2004 15:28, Dmitry Torokhov wrote:
> > [...]
> > >
> > > I see that the kernel correctly identifies both devices so I suspect there
> > > could be a problem with your setup. Could you also post your XF86Config
> > > and tell me the the options you are passing to GPM, please?
> > What I forgot to mention: cat /dev/input/mouse1 gives me some garbage as soon 
> > as I move on the trackpad. But cat /dev/input/mouse0 gives me nothing, so I 
> > don't think that this is a userspace configuration problem. The kernel seems 
> > to get no input from the PS/2 mouse at all.
> 
> Dmitry, this looks like either MUX or PassThrough problem.
> 

It can't be Pass-through problem as the touchpad is not identified as Synaptics,
so it must be MUX...

Emmeran, what happens if you "cat /dev/input/mice" and try working the
touchpad and the trackball? Do you see anything when you use the touchpad?
If not, please #define DEBUG in i8042.c again and after reboot try using
touchpad first, then type something (so we'll see the point when you
stopped using the touchpad), move trackball and type something again and
post your dmesg one more time. This way we would see if there is anything
comes out from the touchpad in MUX mode, etc, etc.

And could you please post your /proc/bus/input/devices? 

Thank you,

Dmitry
