Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTIYANY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 20:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTIYANY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 20:13:24 -0400
Received: from smtp1.fre.skanova.net ([195.67.227.94]:12282 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261602AbTIYANX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 20:13:23 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Zilvinas Valinskas <zilvinas@gemtek.lt>,
       alistair@devzero.co.uk, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm4
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
	<200309221317.42273.alistair@devzero.co.uk>
	<20030922143605.GA9961@gemtek.lt>
	<20030922115509.4d3a3f41.akpm@osdl.org>
	<m2oexc345m.fsf@p4.localdomain> <20030922214526.GD2983@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 25 Sep 2003 02:13:04 +0200
In-Reply-To: <20030922214526.GD2983@ucw.cz>
Message-ID: <m2u171ene7.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Mon, Sep 22, 2003 at 11:27:17PM +0200, Peter Osterlund wrote:
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
> > > >
> > > > Btw Andrew ,
> > > > 
> > > > this change  "Synaptics" -> "SynPS/2" - breaks driver synaptic driver
> > > > from http://w1.894.telia.com/~u89404340/touchpad/index.html. 
> > > > 
> > > > 
> > > > -static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/
> > > > 2", "ImPS/2", "ImExPS/2", "Synaptics"}; 
> > > > +static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
> > > 
> > > You mean it breaks the XFree driver?  Is it just a matter of editing
> > > XF86Config to tell it the new protocl name?
> > 
> > It breaks the event device auto detection, which works by parsing
> > /proc/bus/input/devices. The protocol name is hard coded so you can't
> > just change the XF86Config file.
> > 
> > > Either way, it looks like a change which should be reverted?
> > 
> > I think the new protocol name is better, so why not just fix the X
> > driver instead. Here is a fixed version:
> > 
> > http://w1.894.telia.com/~u89404340/touchpad/synaptics-0.11.4.tar.bz2
> 
> I'd suggest the driver either checks the BUS/VENDOR/DEVICE ids or the
> bitfields for the pad, not the name. Names are unreliable ...

OK, this is now implemented in version 0.11.5, which I just uploaded
to my web site. This version also adds support for the new events
ABS_TOOL_WIDTH, BTN_TOOL_FINGER, BTN_TOOL_DOUBLETAP and
BTN_TOOL_TRIPLETAP.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
