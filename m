Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVBHPbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVBHPbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 10:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVBHPa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 10:30:59 -0500
Received: from adsl-67-64-210-234.dsl.stlsmo.swbell.net ([67.64.210.234]:47028
	"EHLO SpacedOut.fries.net") by vger.kernel.org with ESMTP
	id S261399AbVBHPay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 10:30:54 -0500
Date: Tue, 8 Feb 2005 09:29:49 -0600
From: David Fries <dfries@mail.win.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Linux joydev joystick disconnect patch 2.6.11-rc2
Message-ID: <20050208152949.GA4203@spacedout.fries.net>
References: <20041123212813.GA3196@spacedout.fries.net> <d120d500050201072413193c62@mail.gmail.com> <20050206131241.GA19564@ucw.cz> <200502062021.13726.dtor_core@ameritech.net> <20050207122033.GA16959@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207122033.GA16959@ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 01:20:33PM +0100, Vojtech Pavlik wrote:
> On Sun, Feb 06, 2005 at 08:21:13PM -0500, Dmitry Torokhov wrote:
> 
> This should do it:
> 
> ChangeSet@1.2130, 2005-02-07 13:19:59+01:00, vojtech@suse.cz
>   input: Do a kill_fasync() in input handlers on device disconnect
>          to notify a client using poll() that the device is gone.
>   
>   Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
...
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR

I just checked it against my joystick_select test program which I
included in an earlier e-mail and the blocking read, poll, and select
return when I unplug the joystick.  Thanks for fixing the other
drivers, I didn't think of looking at them.

-- 
David Fries <dfries@mail.win.org>
http://fries.net/~david/pgpkey.txt
