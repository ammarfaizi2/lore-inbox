Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264718AbTE1Mvq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbTE1Mvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:51:46 -0400
Received: from trinity.spray.se ([212.78.193.150]:18636 "EHLO trinity.spray.se")
	by vger.kernel.org with ESMTP id S264718AbTE1Mva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:51:30 -0400
Message-ID: <3ED4B42D.4040204@telia.com>
Date: Wed, 28 May 2003 15:05:49 +0200
From: Jakob Kemi <jakob.kemi@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.70 damaged my nvidia card?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC me as I'm not subscribed.)

Hi,

I have an VIA KT333 + Athlon box with an old, noname AGP GeForce 400 MX 
card.
Upon first booting 2.5.70 i noticed heavy screen flicker. (never seen 
with 2.4.x or 2.5.x < 2.5.70) it behaved nice once in X, upon the next 
reboot i did some work in the console (X not started). Still lots of 
flickering and a misplaced text cursor in text-mode. So i decided to go 
back to my old 2.4 kernel but was unable to boot since my BIOS no longer 
recognizes my graphics card.
When I run the box with an old PCI card as my primary adapter and the 
AGP geforce card as secondary the Geforce card doesnt seem to run it's 
VGA BIOS (no boot message). X also refuses to detect the Geforce card. 
Is it possible that the new console layer or the new agp gart code or 
whatever in 2.5.70 poked in the wrong registers and replaced the BIOS 
flash rom on the GeForce with garbage?
Of course it could very well be something else, but the fact that it 
happened _exactly_ when I switched kernel makes me suspicious.
Some googling reveals that the screen might flicker during flashing of 
the graphics BIOS on geforce cards. Unfortunately since I don't know the 
brand of my card I can't try to replace it's bios.
I should also add that the 2.5.70 build was without framebuffer and that 
other AGP graphic adapters still works in my computer and that my 
Geforce card also doesn't work in other machines.

Any ideas? How much does the kernel poke with the graphic card?

	/ Jakob Kemi

