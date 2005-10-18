Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVJRIeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVJRIeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJRIeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:34:36 -0400
Received: from styx.suse.cz ([82.119.242.94]:30694 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932423AbVJRIef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:34:35 -0400
Date: Tue, 18 Oct 2005 10:34:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adam Belay <ambx1@neo.rr.com>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, dtor_core@ameritech.net,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051018083434.GC13969@ucw.cz>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com> <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de> <20051017232430.GA32655@neo.rr.com> <20051018052617.GA10263@suse.de> <20051018071822.GC32655@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018071822.GC32655@neo.rr.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 03:18:22AM -0400, Adam Belay wrote:

> As stated above, the keyboard actually does have a real location to hang off of.
> Nonetheless, a keyboard controller is a physical device.  It's very different
> from a "virtual device" like a tty.  Therefore, it seems unreasonable to make
> virtual devices belong to the "platform" bus.
> 
> If a device doesn't have a parent device, it belongs at the root of the tree.
> That's the only obvious way to represent such a lack of dependency.  This
> applies to both class and physical devices.
 
Well, a VT is obviously a child of the graphics card and of the
keyboard. Similarly for the 'mice' device, which is a child of all input
devices that offer mouseying capabilities.

It's just impossible to express in a tree.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
