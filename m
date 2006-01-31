Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWAaVCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWAaVCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWAaVCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:02:30 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:58517 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751486AbWAaVC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:02:29 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Tue, 31 Jan 2006 22:02:17 +0100
Cc: linux-kernel@vger.kernel.org, linux-kernel-announce@vger.kernel.org,
       akpm@osdl.org
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: vgacon scrolling problem [Was: Re: 2.6.16-rc1-mm4]
In-reply-to: <drohmk$itt$1@sea.gmane.org>
Message-Id: <20060131210216.6A52A22AEAC@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jindrich Makovicka wrote:
>Jiri Slaby wrote:
>> Jindrich Makovicka wrote:
>>>In vgacon.c, there is a stray printk("vgacon delta: %i\n", lines); which
>>>effectively disables the scrollback of the vga console (at least when
>>>not using the new soft scrollback). Removing it fixes the problem.
>> Then ... could you post a patch?
>if you insist  :) 
Ok, but not that way -- append at least Sign-off (see
Documentation/SubmittingPatches) to allow somebody push it to right places.
And do not remove cc people, please, when replying.

>--- linux-2.6.16-rc1-mm4/drivers/video/console/vgacon.c	2006-01-25 19:16:35.000000000 +0100
>+++ linux-2.6.16-rc1-mm4/drivers/video/console/vgacon.c	2006-01-31 21:33:40.433055896 +0100
>@@ -331,7 +331,6 @@
> 		int margin = c->vc_size_row * 4;
> 		int ul, we, p, st;
> 
>-		printk("vgacon delta: %i\n", lines);
> 		if (vga_rolled_over >
> 		    (c->vc_scr_end - vga_vram_base) + margin) {
> 			ul = c->vc_scr_end - vga_vram_base;
>
>

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
