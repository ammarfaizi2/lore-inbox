Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTKLRR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 12:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTKLRR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 12:17:59 -0500
Received: from gaia.cela.pl ([213.134.162.11]:43273 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263870AbTKLRR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 12:17:57 -0500
Date: Wed, 12 Nov 2003 18:17:26 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Paulo Marques <pmarques@grupopie.com>
cc: Linus Torvalds <torvalds@osdl.org>, Solar Designer <solar@openwall.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
In-Reply-To: <3FB2611C.40608@grupopie.com>
Message-ID: <Pine.LNX.4.44.0311121753240.31972-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maciej Zenczykowski wrote:
> 
> > ....
> > sure now that it wouldn't help - the system is just plain totally 
> > and completely dead, even the system bios is likely dead - including the 
> > System Management Mode code (likely responsible for lighting up the LED 
> > on fn key press/release, which no longer works [although not on every 
> > crash]).
> 
> It is usually the kernel that togles the leds, except when an application (like 
> X) requests that the keyboard be put into RAW mode. In RAW mode it is the 
> application that is responsible to for updating the leds. If X hangs, Caps-Lock 
> and the like will not make the leds toggle anymore.
> 
> You can try to issue a SysRq+R to take the keyboard out of RAW mode into XLATE 
> so that the kernel translates the keys and you might be able to toggle leds, 
> switch consoles, etc.

As I've already written no SysRQ comboes do anything.

I'm speaking about the FN-key led on a laptop which is most definitely not 
kernel toggled - there are 3 keyboard LEDS - Caps, Cursor Keys, Numeric 
Keypad - the first is toggled by caps by the kernel, the second two have 
unusual semantics - the kernel is half responsible and the bios is half 
responsible.  [There is no scroll lock LED]  So the single kernel viewed 
numeric lock LED is visible as two LEDS on the laptop - the kernel can 
toggle a single bit (numlock: off/on) and the SMM Bios sets up how this is 
interpreted.  Normally pressing the FN-key causes the SMM Bios to change 
this hardware intrepretation of the keyboard LED wiring causing a LED to 
light up.  This probably wasn't very clear - but it's definetely not 
kernel [it works during bios performed suspend to disk, etc.] :)

Cheers,
MaZe.

