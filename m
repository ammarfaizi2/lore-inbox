Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbTFLWnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTFLWnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:43:55 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:58048 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265035AbTFLWnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:43:40 -0400
Date: Fri, 13 Jun 2003 00:57:09 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Peter Berg Larsen <pebl@math.ku.dk>
Cc: Peter Osterlund <petero2@telia.com>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030613005709.A27763@ucw.cz>
References: <m27k7rnmwm.fsf@telia.com> <Pine.LNX.4.40.0306122321010.10788-100000@shannon.math.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0306122321010.10788-100000@shannon.math.ku.dk>; from pebl@math.ku.dk on Fri, Jun 13, 2003 at 12:01:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 12:01:35AM +0200, Peter Berg Larsen wrote:
> 
> > > On Wed, Jun 11, 2003 at 10:48:14PM -0400, Joseph Fannin wrote:
> > > > > Here is a new patch that sends ABS_ events to user space. I haven't
> > > > > modified the XFree86 driver to handle this format yet, but I used
> > > > > /dev/input/event* to verify that the driver generates correct data.
> 
> > > CaT <cat@zip.com.au> writes:
> > > Aaaand... will I be able to transparently use my ps2 mouse and touchpad
> > > without having to worry about what's plugged in at any one time?
> 
> The short answer is no, if you still have the gateway laptop.
> 
> 
> On 12 Jun 2003, Peter Osterlund wrote:
> > It works on my computer at least. When loading the psmouse module I
> > get this:
> 
> >         input: PS/2 Logitech Mouse on isa0060/serio2
> >         input: Synaptics Synaptics TouchPad on isa0060/serio4
> 
> It works for you because it (your laptop) has active multiplexing. Without
> active multiplexing I see no way of demultiplexing different mouse
> protocols in mousedev.
> 
> A guestdevice behind the touchpad also needs demultiplexing even with
> activ multiplexing. This could be done in the synaptics driver but as the
> guestdevice can be any device, the synaptics driver needs to know every
> mouse protocol there is to demultiplex it. The synaptics driver sent does
> not demultiplex a guestdevice.

The synaptics driver, if it wished to demultiplex a true mouse protocol
behind the pad without an active multiplexing controller, could easily
create a new serio port, to which the psmouse driver would attach,
detect, and drive the mouse. It's a bit crazy, but it should work.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
