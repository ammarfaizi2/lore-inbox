Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVADGOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVADGOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 01:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVADGOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 01:14:33 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:45492 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262215AbVADGO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 01:14:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [bk patches] Long delayed input update
Date: Tue, 4 Jan 2005 01:14:26 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, vojtech@ucw.cz
References: <20041227142821.GA5309@ucw.cz> <20050103131848.GH26949@ucw.cz> <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501040114.26499.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 January 2005 12:54 am, Linus Torvalds wrote:
> 
> I pulled and immediately unpulled again.
> 
> Vojtech, stuff like this is unacceptable:
> 
> 	PS/2 driver library (SERIO_LIBPS2) [N/m/y/?] (NEW) ?
> 
> 	Say Y here if you are using a driver for device connected
> 	to a PS/2 port, such as PS/2 mouse or standard AT keyboard.
> 
> Stop messing with peoples minds. The default config should contain
> keyboard and mouse support, and unless the user asks for "Embedded" or the
> year 2010 comes along and you can't find computers with non-USB keyboards
> anyway, that's how it's going to remain.
> 
> We had this _idiocy_ early in 2.5.x, and it caused untold silly problems. 
> We fixed it. We're not going to re-do that mistake.
> 

When I do "make oldconfig" it silently sets SERIO_LIBPS2 to Y if I have
either atkbd or psmouse built-in and if both of them are modules it gives
option [M/y]. Do you have atkbd or psmouse selected?

> Please re-do your BK tree without this. Also, considering that every
> _single_ time we've messed with the legacy keyboard/mouse controller there
> have been compatibility problems, I want to know what the advantages are.  

It folds sizeable chunks of the same code from atkbd and psmouse so for ease
of maintenance.

-- 
Dmitry
