Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTIVVpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbTIVVpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:45:51 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:42965 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263069AbTIVVpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:45:44 -0400
Date: Mon, 22 Sep 2003 23:45:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, Zilvinas Valinskas <zilvinas@gemtek.lt>,
       alistair@devzero.co.uk, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test5-mm4
Message-ID: <20030922214526.GD2983@ucw.cz>
References: <20030922013548.6e5a5dcf.akpm@osdl.org> <200309221317.42273.alistair@devzero.co.uk> <20030922143605.GA9961@gemtek.lt> <20030922115509.4d3a3f41.akpm@osdl.org> <m2oexc345m.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2oexc345m.fsf@p4.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 11:27:17PM +0200, Peter Osterlund wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
> > >
> > > Btw Andrew ,
> > > 
> > > this change  "Synaptics" -> "SynPS/2" - breaks driver synaptic driver
> > > from http://w1.894.telia.com/~u89404340/touchpad/index.html. 
> > > 
> > > 
> > > -static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/
> > > 2", "ImPS/2", "ImExPS/2", "Synaptics"}; 
> > > +static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
> > 
> > You mean it breaks the XFree driver?  Is it just a matter of editing
> > XF86Config to tell it the new protocl name?
> 
> It breaks the event device auto detection, which works by parsing
> /proc/bus/input/devices. The protocol name is hard coded so you can't
> just change the XF86Config file.
> 
> > Either way, it looks like a change which should be reverted?
> 
> I think the new protocol name is better, so why not just fix the X
> driver instead. Here is a fixed version:
> 
> http://w1.894.telia.com/~u89404340/touchpad/synaptics-0.11.4.tar.bz2

I'd suggest the driver either checks the BUS/VENDOR/DEVICE ids or the
bitfields for the pad, not the name. Names are unreliable ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
