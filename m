Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUABNWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbUABNWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:22:23 -0500
Received: from postbode02.zonnet.nl ([62.58.50.89]:12225 "EHLO
	postbode02.zonnet.nl") by vger.kernel.org with ESMTP
	id S265539AbUABNUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:20:33 -0500
From: S Ait-Kassi <sait-kassi@zonnet.nl>
To: linux-kernel@vger.kernel.org
Subject: [update]  Vesafb problem since 2.5.51
Date: Fri, 2 Jan 2004 14:22:44 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401021422.44324.sait-kassi@zonnet.nl>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.2; VDF: 6.23.0.22; host: postbode02.zonnet.nl)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I figured out in which kernel the problem I was having appeared. It seems to 
work with 2.5.50 and the problems starts with 2.5.51.

I've looked at the changelog and showed these changes that might have 
contibuted to my problem;

-There are some changes in fbcon. Made modular along with some fixes and some 
vesafb fixes.

-Accel wrapper is now intergarted into fbcon.c. VESA fb fixes 

-Made fbcon modular.

-New NVIDIA and Radeon cards pci ids. Soon I will add support for these :-) 
Also a needed fix for fbcon.c. 

-Moved AGP and DRM code back to drivers/char until a proper solution is done 
for handling AGP/DMA based framebuffer devices.

Almost all changes by the same developer <jsimmons>. I've been looking
at the source differences but the introduction of the fbcon module really 
complicates the matter.

I was wondering where to go about reporting the 
problem or where this issue might stem from. (i.e. the includes shown in 
vesafb.h, vesafb.h itself, fb.h or the fbcon module related code.

Or would it be best to just mail the developer? :)
Any help is appreciated.

Regards,

P.S.: Here is the part of my original mail describing the problem. It has been 
confirmed by two other submits to this mailinglist regarding the 2.6.0-test4 
kernel. I'm using the 2.6.0.-bk3 kernel myself.

>The most apparent occurrence of the problem for me is when 
>running mc (Midnight Commander). The blue blackground isn't drawn in the 
>parts where there is no text. When using mcedit this comes all the more clear 
>and  particularly when scrolling is done. The space which hasn't got any text 
>is replaced with RGB pixels (looks grey from a distance). If you jump back 
>from one console and back again the screen is redrawn correctly.


