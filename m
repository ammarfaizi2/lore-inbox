Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbTAPQNl>; Thu, 16 Jan 2003 11:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbTAPQNl>; Thu, 16 Jan 2003 11:13:41 -0500
Received: from air-2.osdl.org ([65.172.181.6]:29578 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267159AbTAPQNk>;
	Thu, 16 Jan 2003 11:13:40 -0500
Date: Thu, 16 Jan 2003 08:18:04 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>,
       <alan@lxorguk.ukuu.org.uk>
Subject: Re: MB without keyboard controller / USB-only keyboard ?
In-Reply-To: <20030116120324.2b97e010.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33L2.0301160805110.9551-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Stephan von Krawczynski wrote:

| On Thu, 9 Jan 2003 23:24:59 +0100
| Vojtech Pavlik <vojtech@suse.cz> wrote:
|
| > On Thu, Jan 09, 2003 at 11:42:47AM +0100, Stephan von Krawczynski wrote:
| > > Hello all,
| > >
| > > how do I work with a mb that contains no keyboard controller, but has only
| > > USB for keyboard and mouse?
| > > While booting the kernel I get:
| > >
| > > pc_keyb: controller jammed (0xFF)
| > >
| > > (a lot of these :-)
| > >
| > > and afterwards I cannot use the USB keyboard.
| > > Everything works with a mb that contains a keyboard-controller, but where I
| > > use a USB keyboard.
| >
| > Get 2.5. ;) It should work without a kbd controller ... you can even
| > disable it in the kernel config ...
|
| Nice idea, but not acceptable as this setup is for production use, you simply
| won't do that.
| It would be helpful if there was a kernel parameter for disabling the
| keyboard(-check) in 2.4. We found out that disabling it as kernel patch is not
| the right way, as standard setups with keyboard controller do not work any
| longer afterwards. This is a setup where user should be able to choose...
| The box contains a BIOS where I can type around with USB-keyboard, btw.

I asked 1 week ago if the system BIOS does PS/2 keyboard emulation.
I think you are saying here that it does, so I'll try to confirm that:

Does the USB keyboard work when talking to BIOS Setup?
Does the USB keyboard work if NO Linux USB drivers are loaded?
Or are you using the USB keyboard only by having Linux USB drivers
loaded?

I posted a patch to 2.4.20 on 2002-Dec-04 that might work for you.
It's available at
  http://www.osdl.org/archive/rddunlap/patches/kbc_option_2420.patch

It might work for you.  If you try it out, please let me know how it
does for you.

-- 
~Randy


