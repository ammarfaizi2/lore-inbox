Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUGEO0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUGEO0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 10:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUGEO0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 10:26:44 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:63573 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266128AbUGEO0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 10:26:11 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Synaptics not working with 2.6.7-mm6 (usb fixed)
Date: Mon, 5 Jul 2004 09:26:08 -0500
User-Agent: KMail/1.6.2
Cc: Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>
References: <20040705131002.GA14768@gamma.logic.tuwien.ac.at> <20040705134723.GA17146@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040705134723.GA17146@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407050926.08739.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 July 2004 08:47 am, Norbert Preining wrote:
> Hi Andrew, hi list!
> 
> As a follow up to the previous email concerning deadlocks with -mm6 here
> a more detailed description concerning the synaptics device not being
> found:
> 
> Here is the relevant part of the dmesg output with -mm6:
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: PS/2 Generic Mouse on isa0060/serio1
> 
> and here with a working -mm5:
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> Synaptics Touchpad, model: 1
>  Firmware: 5.8
>  180 degree mounted touchpad
>  Sensor: 29
>  new absolute packet format
>  Touchpad has extended capability bits
>  -> 4 multi-buttons, i.e. besides standard buttons
>  -> multifinger detection
>  -> palm detection
> input: SynPS/2 Synaptics TouchPad on isa0060/serio1
> 
> 
> THe only difference I have between mm5 and mm6 is that I disabled
> framebuffer and made *all* usb modular (before the hci and some more
> were compiled in -- I am testing S2R).
> 
> Do you have any idea what might have done this?
>

Try making psmouse modular as well and load it _after_ all USB stuff is
loaded - you may be having issues with USB Legacy emulation.

-- 
Dmitry
