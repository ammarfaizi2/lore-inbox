Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVCHU67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVCHU67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVCHU4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:56:49 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:34022 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261541AbVCHUv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:51:27 -0500
Date: Tue, 8 Mar 2005 21:52:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Esben Stien <b0ef@esben-stien.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
Message-ID: <20050308205210.GA3986@ucw.cz>
References: <873bxfoq7g.fsf@quasar.esben-stien.name> <87zmylaenr.fsf@quasar.esben-stien.name> <20050204195410.GA5279@ucw.cz> <873bvyfsvs.fsf@quasar.esben-stien.name> <87zmxil0g8.fsf@quasar.esben-stien.name> <1110056942.16541.4.camel@localhost> <87sm37vfre.fsf@quasar.esben-stien.name> <87wtsjtii6.fsf@quasar.esben-stien.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wtsjtii6.fsf@quasar.esben-stien.name>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 07:31:45PM +0100, Esben Stien wrote:
> Esben Stien <b0ef@esben-stien.name> writes:
> 
> > Hmm, I'm getting the same hash for evdev.c between 2.6.10 and
> > 2.6.11. I hope Vojtech Pavlik got the reports.
> 
> Ahh, I see he got lots of juicy patches lined up. I guess I'll try
> linux-2.6.11-mm1 then.

I don't think I have a patch for the MX1000 among them. I do have the
MX1000, though, and I'm still thinking about what to do with it.

The problem is that the mouse really does reports all the double-button
stuff and autorepeat, and horizontal wheel together with button press on
wheel tilt.

It has all that in the report descriptor, and the HID driver correctly
interprets it and passes it on.

It's annoying, though.

I could kill the extra buttons (via a HID quirk), which would leave us
with autoscroll up/down/left/right, but the wheel wouldn't be
distinguishable from the autoscroll anymore.

I can't kill the autoscroll alone and leave the buttons, because again
the driver can't easily tell if it's the wheel or not.

In the end I think the best option is to leave the filtering to
userspace, which will mean more configuration necessary in the X event
mouse driver.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
