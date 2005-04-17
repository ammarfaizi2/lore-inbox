Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVDQXVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVDQXVq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVDQXVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:21:46 -0400
Received: from open.hands.com ([195.224.53.39]:35282 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261538AbVDQXVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:21:42 -0400
Date: Mon, 18 Apr 2005 00:30:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: SkyMinder (CLPS711x derivative) - decided to try 2.6.11.7
Message-ID: <20050417233052.GH18167@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... aaand it flopped.  i'm not even getting data out of the
serial console - not a squeak.  HELP!

the patch is quite large - and contains [working in 2.4.27] a
lot of untested stuff - naturally, if i don't get a squeak out
of the serial console.  features include support for CPU_FREQ
which is a bitch on the CLPS711x because the bloody serial
uarts are tied to the PLLW, which changes of course depending
on clock speed (!!!).

anyway.

patch INCLUDING config file can be viewed at:

	http://lkcl.net/skyminder

the physical setup (memory etc.) is pretty much identical to
an EDB7312.

oh - i also added a #define for FIQ_START, which makes it
possible to enable the FIQ code (CONFIG_FIQ).

boot is performed using a drastically modified version of
armboot [which works perfectly for the 2.4.27 kernel].

kernel is loaded into memory at 0xc0800000.
${CROSS_COMPILE}-objcopy is used to prepare a linux.bin.
mkimage is used to prepare that into an appropriate format...

${CROSS_COMPILE} is set to arm-unknown-linux-gnu-

arm-unknown-linux-gnu-gcc --version gives 3.3.3


the only thing _not_ working on the 2.4.27 kernel was the
keyboard driver: as soon as that was loaded (as either an input
device _or_ a keyboard device - yes i tried both variations,
basing the code on both pc_keyb.c _and_ usbkbd.c) then the
console _instantly_ crashed.

i got sufficiently pissed off with 2.4.27 that i decided to
go to 2.6, and i'm stuck before i can even begin.

2.4.27 compiles with arm-linux-gcc, version 2.95.1


help, help, gloop, gloop, there's a lot riding on getting this
working: where do i start when you can't even see anything
coming out of the serial console?

any help much appreciated.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
