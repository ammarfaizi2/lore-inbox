Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUE2Np5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUE2Np5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUE2Np5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:45:57 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:31620 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264276AbUE2Np4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:45:56 -0400
Date: Sat, 29 May 2004 15:46:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Chris Osicki <osk@osk.ch>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040529134614.GA6420@ucw.cz>
References: <20040525201616.GE6512@gucio> <20040528194136.GA5175@pclin040.win.tue.nl> <20040528214620.GA2352@gucio> <20040529132320.GC5175@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529132320.GC5175@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 03:23:20PM +0200, Andries Brouwer wrote:

> >>> But showkeys -s shows 0x5b when the key in question is pressed
> >>> (and no release event!!??)
> 
> 0x5b is 91 which is x86_keycodes[101].
> 
> Yes, so all is clear:
> The 2.6 kernel no longer has a raw mode - it has a simulated raw mode
> that is not very raw. When you updated the table used for the
> scancode->keycode translation, the table used to reconstruct what
> might have been the original scancode was not changed accordingly.
> Thus, showkeys -s gave a garbage answer.
> 
> Thanks for the report. It shows that resurrecting raw mode is even
> more desirable than I thought at first.

What for?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
