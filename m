Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbUL1CgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbUL1CgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUL1CgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:36:14 -0500
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:7892 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262018AbUL1CgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:36:10 -0500
Date: Mon, 27 Dec 2004 20:36:02 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ho ho ho - Linux v2.6.10
Message-ID: <20041228023602.GA4158@yggdrasil.localdomain>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <20041226203517.GA4081@yggdrasil.localdomain> <200412262031.39066.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412262031.39066.dtor_core@ameritech.net>
X-Operating-System: Linux yggdrasil 2.6.10 #1 SMP Sun Dec 26 14:12:08 CST 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 08:31:38PM -0500, Dmitry Torokhov wrote:
> > My ps/2 keyboard (an relatively uninteresting Labtec 104-key model)
> > doesn't work with 2.6.10, although 2.6.9 and the BIOS seem to have no 
> > issues with it.  I've gone through the changelog and double-checked my 
> > .config (attached), and don't see any obvious problems... any thoughts?
> 
> Anything interesting in dmesg? And what about mouse? You may have to change
> #undef DEBUG to #define DEBUG in drivers/input/serio/i8042.c and post your
> full dmesg.

OK, I figured it out (I think).  I normally go through a Avocent KVM
switch (USB), to share the keyboard and mouse between multiple systems. 
Unfortunately the keyboard died a week or so ago, so I plugged a ps/2
model directly into the main box as a temporary measure... but didn't
think to disconnect the KVM.  After doing so, 2.6.10 correctly detects 
the keyboard on bootup and everything seems to be working correctly.

I haven't pursued it any farther, although I'd be happy to do so if
anyone thinks it would be beneficial.  My guess is that only a single
keyboard is allowed, and 2.6.10 simply saw the USB one first.  Not sure
if that was caused by an explicit change in the code, or merely due to
the order in which the drivers were linked in.  Either way, I'm up and 
running. ;-)

Thanx for your assistance!
