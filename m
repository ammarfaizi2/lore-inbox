Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUAJRnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUAJRnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:43:20 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:62882 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265294AbUAJRm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:42:59 -0500
Date: Sat, 10 Jan 2004 18:42:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Westgate <oryn@oryn.fsck.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.1 synaptics problems tapping and tap'n'drag
Message-ID: <20040110174256.GA22095@ucw.cz>
References: <3FFF337E.3040603@oryn.fsck.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFF337E.3040603@oryn.fsck.tv>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 11:04:30PM +0000, Jon Westgate wrote:
> Hi,
> I'm not sure if this is the right place to ask but if I run 2.6.1
> I get mouse problems that I didn't get with 2.6.0
> I'm running a compaq m300 (600MHz PIII) with a synaptics touch pad.
> 
> In 2.6.0 there was an option to include or not include support for the 
> synaptics touchpad (I found that my touchpad worked just fine with that 
> option unchecked) in 2.6.1 that option is nolonger there.
> 
> In 2.6.1 I find that the operation of the mouse is very erratic its 
> almost impossible to take your finger off the pad without the cursor 
> moving, Tapping doesn't work, The pad seems very accelerated (ie you 
> drag your finger a short distance and the cursor is at the other side of 
> the screen before you know it), Lastly if you dragged your finger to the 
> edge of the pad it used to continue on smoothly. This no longer works.
> 
> My question is:
> Is there a command line or append option I can put in lilo.conf to 
> prevent the synaptics driver from trying to reprogram my touchpad? I 
> quite like its default behavior. There is definatly something trying to 
> reprogram it as I have to turn off my laptop for it's behavior to return 
> to normal. Even if I reset it still needs a power cycle to fix it.
> dmesg says my touchpad is this:
> input: PS/2 Synaptics TouchPad on isa0060/serio4
> 
> I'm not running any special drivers or settings in XF86Config
> I just have /dev/input/mice setup with protocol set as ImPS/2

The default simple backward-compatibility mousedev module doesn't
support taps and drags. You need the XFree86 synaptics driver from
http://w1.894.telia.com/~u89404340/touchpad/index.html. It'll work
together with the in-kernel driver and give you all the features the pad
has.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
