Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbUKUSIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbUKUSIe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUKUSIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:08:34 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:45192 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S261758AbUKUSIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:08:19 -0500
Date: Sun, 21 Nov 2004 19:08:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-input@atrey.karlin.mff.cuni.cz,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] small input cleanup
Message-ID: <20041121180824.GA2538@ucw.cz>
References: <20041107031256.GD14308@stusta.de> <200411062249.54887.dtor_core@ameritech.net> <20041107172929.GM14308@stusta.de> <20041107174757.GA10086@ucw.cz> <20041121174832.GB2924@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121174832.GB2924@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 06:48:33PM +0100, Adrian Bunk wrote:

> > Well, it works in its current form, and drivers should call it when
> > their reinit logic fails to reinitialize the device. They don't, which
> > is a bug, and should be fixed. I don't think removing gameport_rescan()
> > will help fixing them.
> 
> Fine with me.
> 
> > > - could ps2_sendbyte be #ifdef 0'ed until it's required?
> > >   this way, it wouldn't make the kernel bigger today
> >  
> > It is used, just not outside libps2. Does the EXPORT_SYMBOL() make the
> > kernel so much bigger?
> 
> It doesn't make a big difference, but if an EXPORT_SYMBOL isn't required 
> (and won't be required in the near future), where's the point keeping 
> it?
> 
> The situation is clearly different if in-kernel users from other files 
> will be added in the near future.

So far all devices only need proper commands per PS/2 specification. The
export is there in case some device will need to be sent separate bytes
outside the command structure. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
