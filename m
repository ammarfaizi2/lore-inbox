Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVDGSM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVDGSM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVDGSM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:12:57 -0400
Received: from open.hands.com ([195.224.53.39]:12482 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S262532AbVDGSMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:12:25 -0400
Date: Thu, 7 Apr 2005 19:21:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.27 arm skyminder] writing new keyboard handler - help!
Message-ID: <20050407182135.GZ19784@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, please respond cc to me because i am not on the lkml.

for a new arm linux embedded device called a skyminder, i'm responsible
for getting all the drivers working.  ha ha.

the success of this device presents the linux community with
an opportunity to own a linux-based mobile phone (even if it's
not a very small phone - 8cm x 10cm x 1cm) - and it has a GPS
module in it, as well.

i'm endeavouring to adapt various bits of code to create a
keyboard driver.  they've adopted 2.4.27 and are too far down
the line to move to 2.6 - yet.

i particularly want to avoid - if i can - compiling this keyboard
driver under development into the kernel (even though it's the primary
keyboard) because downloading 600k over a serial link into flash ram
isn't a) funny b) a good idea c) slows development time down.

with that in mind, so far, i have:

- cut/paste pc_keyb.c just like everyone else has (in celps_keyb.c,
  c711x_keyb.c, dummy_keyb.c etc.) to create k_translate,
  k_unexpected_up, k_setkeycode and k_getkeycode routines.

- cut/paste usbkbd.c and adapted it to successfully call
  input_report_key on a key press and key release.

then, on installation of module input, keybdev and sky_buttons,
i happily get debug messages indicating key presses (keycode 31
indicating 's') ... but no actual key events appear down my serial
console.

so, my question is: does anyone know off the top of their heads what i
may have missed out that causes the keybdev event handler to _not_
actually stuff keys out?

am i... like... missing something really obvious, given that
the console has been set to "serial"?

where should i look to, to find the keys being outputted, if they're
going anywhere?

help, help, gloop.

cheers,

l.




-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
