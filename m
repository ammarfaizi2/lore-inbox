Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTIYMn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 08:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbTIYMn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 08:43:59 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:58061 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261344AbTIYMn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 08:43:56 -0400
Date: Thu, 25 Sep 2003 14:43:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>, alistair@devzero.co.uk,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm4
Message-ID: <20030925124315.GB24049@ucw.cz>
References: <20030922013548.6e5a5dcf.akpm@osdl.org> <200309221317.42273.alistair@devzero.co.uk> <20030922143605.GA9961@gemtek.lt> <20030922115509.4d3a3f41.akpm@osdl.org> <m2oexc345m.fsf@p4.localdomain> <20030922214526.GD2983@ucw.cz> <m2u171ene7.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2u171ene7.fsf@p4.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 02:13:04AM +0200, Peter Osterlund wrote:

> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Mon, Sep 22, 2003 at 11:27:17PM +0200, Peter Osterlund wrote:
> > > Andrew Morton <akpm@osdl.org> writes:
> > > 
> > > > Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
> > > > >
> > > > > Btw Andrew ,
> > > > > 
> > > > > this change  "Synaptics" -> "SynPS/2" - breaks driver synaptic driver
> > > > > from http://w1.894.telia.com/~u89404340/touchpad/index.html. 
> > > > > 
> > > > > 
> > > > > -static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/
> > > > > 2", "ImPS/2", "ImExPS/2", "Synaptics"}; 
> > > > > +static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
> > > > 
> > > > You mean it breaks the XFree driver?  Is it just a matter of editing
> > > > XF86Config to tell it the new protocl name?
> > > 
> > > It breaks the event device auto detection, which works by parsing
> > > /proc/bus/input/devices. The protocol name is hard coded so you can't
> > > just change the XF86Config file.
> > > 
> > > > Either way, it looks like a change which should be reverted?
> > > 
> > > I think the new protocol name is better, so why not just fix the X
> > > driver instead. Here is a fixed version:
> > > 
> > > http://w1.894.telia.com/~u89404340/touchpad/synaptics-0.11.4.tar.bz2
> > 
> > I'd suggest the driver either checks the BUS/VENDOR/DEVICE ids or the
> > bitfields for the pad, not the name. Names are unreliable ...
> 
> OK, this is now implemented in version 0.11.5, which I just uploaded
> to my web site. This version also adds support for the new events
> ABS_TOOL_WIDTH, BTN_TOOL_FINGER, BTN_TOOL_DOUBLETAP and
> BTN_TOOL_TRIPLETAP.

Great, thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
