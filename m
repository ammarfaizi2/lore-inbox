Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274788AbTHKTZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273257AbTHKTYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:24:00 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:19918 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S273298AbTHKTXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:23:45 -0400
Date: Mon, 11 Aug 2003 21:22:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Johannes Stezenbach <js@convergence.de>, Gerd Knorr <kraxel@bytesex.org>,
       Flameeyes <dgp85@users.sourceforge.net>, Pavel Machek <pavel@suse.cz>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811192234.GO2627@elf.ucw.cz>
References: <1060616931.8472.22.camel@defiant.flameeyes> <20030811163913.GA16568@bytesex.org> <20030811175642.GC2053@convergence.de> <20030811185947.GA8549@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811185947.GA8549@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If a remote control has e.g. a "1" key this doesn't mean that a user
> > wants a "1" to be written into your editor while editing source code.
> > The "1" key on a remote control simply has a differnt _meaning_ than
> > the "1" key on your keyboard -- depending of course on what the user
> > thinks this key should mean.
> 
> That's what BTN_1 is for. ;)

Perhaps comment about this should be added to input.h?

--- clean/include/linux/input.h	2003-06-24 12:28:05.000000000 +0200
+++ linux/include/linux/input.h	2003-08-11 21:17:46.000000000 +0200
@@ -338,6 +338,7 @@
 
 #define KEY_UNKNOWN		240
 
+/* This is for keys 0..9 on remote control etc. */
 #define BTN_MISC		0x100
 #define BTN_0			0x100
 #define BTN_1			0x101


I still miss few descriptions... On avermedia remote control there are
buttons labeled as "preview", "autoscan", "freeze", "capture" and few
keys without label (5 of them :-(). I mapped that somehow, but it
might not be ideal:

        case 0xc577c0: return KEY_EJECTCD;      /* Unmarked on my controller */
        case 0xd77c0: return KEY_INFO; /* preview */
        case 0xad77c0: return KEY_SEARCH; /* autoscan */
        case 0x6d77c0: return KEY_BREAK; /* freeze */
        case 0xed77c0: return KEY_PVR; /* capture */

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
