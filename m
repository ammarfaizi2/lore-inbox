Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVADFzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVADFzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVADFzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:55:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:48321 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262051AbVADFzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 00:55:00 -0500
Date: Mon, 3 Jan 2005 21:54:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, vojtech@ucw.cz
Subject: Re: [bk patches] Long delayed input update
In-Reply-To: <20050103131848.GH26949@ucw.cz>
Message-ID: <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
References: <20041227142821.GA5309@ucw.cz> <200412271419.46143.dtor_core@ameritech.net>
 <20050103131848.GH26949@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I pulled and immediately unpulled again.

Vojtech, stuff like this is unacceptable:

	PS/2 driver library (SERIO_LIBPS2) [N/m/y/?] (NEW) ?

	Say Y here if you are using a driver for device connected
	to a PS/2 port, such as PS/2 mouse or standard AT keyboard.

Stop messing with peoples minds. The default config should contain
keyboard and mouse support, and unless the user asks for "Embedded" or the
year 2010 comes along and you can't find computers with non-USB keyboards
anyway, that's how it's going to remain.

We had this _idiocy_ early in 2.5.x, and it caused untold silly problems. 
We fixed it. We're not going to re-do that mistake.

Please re-do your BK tree without this. Also, considering that every
_single_ time we've messed with the legacy keyboard/mouse controller there
have been compatibility problems, I want to know what the advantages are.  
Does the work actually _fix_ anything, and has it in any way been tested
on the millions of different versions of kbd controller clones out there?

		Linus
