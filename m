Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbRFHELO>; Fri, 8 Jun 2001 00:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbRFHELF>; Fri, 8 Jun 2001 00:11:05 -0400
Received: from mailrtr04.ntelos.net ([216.12.0.104]:33447 "EHLO
	mailrtr04.ntelos.net") by vger.kernel.org with ESMTP
	id <S261805AbRFHEKq>; Fri, 8 Jun 2001 00:10:46 -0400
Message-Id: <200106080410.f584Aj021251@mailrtr04.ntelos.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "Aaron Krowne" <akrowne@vt.edu>
To: linux-kernel@vger.kernel.org
Subject: what's up with IRQ routing in 2.4.x ?
X-Mailer: Pronto v2.2.3 On linux/mysql
Date: 08 Jun 2001 00:10:43 EDT
Reply-To: "Aaron Krowne" <akrowne@vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.  I've been wondering about the behavior of linux IRQ routing on
certain systems running 2.4.x kernels (particularly .3 and above).  

I have an AMD KT133A system.  I have two friends with PIII-based laptops (one
toshiba, one thinkpad.)  We have all noticed the exact same strange behavior
despite our various hardware.  We're all running linux 2.4.4 or 2.4.5.	The
strange thing is that, whenever it has the opportunity to set an IRQ, linux
puts the device in question on the same IRQ which seems fixed for the system. 
But it gets stranger.  This IRQ is always IRQ 11.  On all 3 systems.  On my
system, I can specify "assign IRQ for USB".  When I do this, USB gets its own
IRQ and works (sorta).	When I do not, USB goes on IRQ 11 too!	And, in this
case, lots of devices on USB refuse their addresses and such, which does not
happen when USB has its own IRQ.

What gives?  Shouldn't devices go to whatever IRQs are free, instead of sharing
when there is no need to share?  Now, I would just find this a curiosity,
except I think it adversely effects devices in many cases.  For example, on the
toshiba, the sound card and ethernet card share an IRQ.  This makes the sound
card flakey.  Sometimes the driver for the sound card will not load at boot. 
Some times the device stops responding when in use (as playing an mp3).  On my
desktop AMD machine, I always get "PIRQ routing error" at boot, as my network
card and sound card also share an IRQ.	Also, my two USB ports share the same
IRQ, and I think this is causing problems with some devices (for instance, my
digital camera used to respond to my PC in linux, but then this randomly
stopped working).  

This would not be so bad if we could somehow manually assign IRQs until this
behavior is fixed.  But there is really no way to this via software in linux. 
Perhaps I am just uneducated, but setpci has never worked for this purpose
despite my best attempts.  I'm fairly sure this is possible, as many devices
can do this under windows.  (But.. shouldn't devices be able to share IRQs and
function fine?) At any rate, this appears to be impeding the usefulness of
devices that are otherwise supported.  

Any advice/info would be appreciated (I can provide logs for diagnostic
purposes, upon request.)

Aaron Krowne


