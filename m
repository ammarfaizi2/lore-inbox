Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUAKUfh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 15:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUAKUfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 15:35:36 -0500
Received: from mail.bluebottle.com ([69.20.6.25]:53935 "EHLO mail.bluebottle")
	by vger.kernel.org with ESMTP id S265977AbUAKUf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 15:35:27 -0500
Date: Sun, 11 Jan 2004 18:35:21 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel
 2.6.1
In-Reply-To: <200401111545.59290.murilo_pontes@yahoo.com.br>
Message-ID: <Pine.LNX.4.58.0401111831070.342@pervalidus.dyndns.org>
References: <200401111545.59290.murilo_pontes@yahoo.com.br>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jan 2004, Murilo Pontes wrote:

>
> 15:34:36 [root@murilo:/MRX/drivers]#diff -urN linux-2.6.0/drivers/input/keyboard/atkbd.c linux-2.6.1/drivers/input/keyboard/atkbd.c > test.diff
> 15:35:12 [root@murilo:/MRX/drivers]#wc -l test.diff
>     387 test.diff
> -------------> May be wrong?!
>
> 15:30:13 [root@murilo:/MRX/drivers]#dmesg | grep serio
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> ----------> Last two lines, is apper each startx startup!!!!

Also reported by me - see
http://marc.theaimsgroup.com/?l=linux-kernel&m=107376128814606&w=2

showkey under 2.4: keycode  89

But I didn't use startx, only the frame buffer. Maybe why I
didn't get such "atkbd.c: Unknown key released (translated set
2, code 0x7a on isa0060/serio0)." messages ?

Vojtech: Does "[PATCH] Re: bad scancode for USB keyboard" -
http://marc.theaimsgroup.com/?l=linux-kernel&m=107384731209938&w=2
also fix it ?

-- 
http://www.pervalidus.net/contact.html
