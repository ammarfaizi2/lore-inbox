Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTBKTHR>; Tue, 11 Feb 2003 14:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbTBKTHR>; Tue, 11 Feb 2003 14:07:17 -0500
Received: from gonzo.one-2-one.net ([217.115.142.69]:6673 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S264936AbTBKTHQ>; Tue, 11 Feb 2003 14:07:16 -0500
Date: Tue, 11 Feb 2003 19:15:02 +0100
From: stefan.eletzhofer@eletztrick.de
To: linux-kernel@vger.kernel.org
Subject: Re: Keyboard Writing
Message-ID: <20030211181502.GA26990@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.50.0302111142060.53-100000@oscar.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.50.0302111142060.53-100000@oscar.cc.gatech.edu>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 12:01:38PM -0500, James Gibson Fusia wrote:
> I've read through the keyboard driver files (kd.h, keyboard*, pc_keyb*),
> and come to the conclusion that you can't write to the keyboard. Get mode,
> set mode, get leds, set leds, change keymap. But no write to keyboard.
> 
> I need to be able to re-program a keyboard from userspace, and this
> involves sending certain keycodes to the keyboard via port manipulation
> (set write bit, write, wait for write bit clear.. blah blah blah), and no
> manipulation handles.
> 
> My question to you, then, is how do I add definitions for ioctl to be able
> to write to the ps/2 keyboard from user-space? (the #defs for
> KD(GET|SET)LED seem to be arbitrary and not related to 0x64).
> 
> Essentially, I would like to be able to treat the keyboard like a serial
> port. Any docs you can point me at? (Yes, I've checked everything google
> showed me and none of it seemed pertinent to physically writing to the
> keyboard.)
> 
> Please respond directly to me, as I'm a bum and don't want to join the
> kernel-dev list.
> 			-James Gibson Fusia (visyz@cc.gatech.edu)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hi, I needed to do the same for one of my customer's embedded board, which has
some battery controller PIC attached to the PS/2 kbd.
I needed to access this PIC, but found no other way but copy the existing
keyboard driver and hack that one.

Cheers,
	Stefan
-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer
Gottlieb-Daimler-Strasse 10
88214 Ravensburg
GERMANY
http://www.eletztrick.de
http://hackkit.eletztrick.de
mailto://stefan.eletzhofer@eletztrick.de
+49 751 35 44 112
+49 751 35 44 115 (FAX)
