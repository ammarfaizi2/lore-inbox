Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTJXRfP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 13:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTJXRfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 13:35:15 -0400
Received: from not.theboonies.us ([66.139.79.224]:15273 "EHLO
	not.theboonies.us") by vger.kernel.org with ESMTP id S262420AbTJXRfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 13:35:09 -0400
Message-ID: <1067021062.3f9973069378a@mail.theboonies.us>
Date: Fri, 24 Oct 2003 13:44:22 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 + fb patch = dead PowerBook
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 81.196.140.33
From: David Eger <random-temp_addy-1067625873.f45fe1@theboonies.us>
X-Delivery-Agent: TMDA/0.84 (Tim Tam)
X-Primary-Address: random@theboonies.us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided a week ago to work on bringing the Radeon driver up-to-date for Linux 
2.6 -- essentially a forward port of BenH's 2.4 driver + some acceleration code 
from xfree86.

My PowerBook is now toast.  I'm hoping someone might give me some hints on 
resurrecting it.  Here's the story:

1. Dowloaded linux-2.6.0-test8.  Compiled.  Rebooted.  My lcd didn't show 
anything once tux was supposed to appear.

2. Decided "must be a bad radeon driver".  Forward ported BenH's driver, 
ifdef'ing out all of the Power Management code and console ugliness.

3. Compiled this patched kernel.  Rebooted.  Hung, I believe, detecting a 
mouse.  strange.

4. Checked my .config from linux-2.4.22-ben2.  Oh.  I'll try enabling VGA 
console in addition to FB console, and those other "Apple" framebuffers just 
for kicks in my 2.6.0-test8+ kernel.

5. Compile. Reboot.  tux! login prompt! Rock! login.  just for kicks, startx.  
X starts! Rock!  Okay, reboot to linux-2.4 so I can clean up the new driver.  X 
gets killed and video goes weird during shut down.  That's expected, though, as 
I disabled some of the Power Management codes.

My machine never reboots properly.

It will get to the end of openpic() right before tux is supposed to appear and 
dies.  Linux-2.4.22-ben2, MacOSX, Linux-2.6.0-test8+, Gentoo Install CD, MacOSX 
install CD, they all die somewhere during kernel initialization.  The only 
thing I can get to boot is the Hardware Test CD.

I figure, "okay, I must have screwed with some registers improperly.  I'll just 
unplug it, take the battery out, let all of the registers settle down to zero 
and reboot it later.  I'll even hit that reset switch on the PMU just in case."

None of this helps.

Any ideas?

-Eger David, in Budapest
