Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUCHXhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUCHXhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:37:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:49326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261241AbUCHXha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:37:30 -0500
Date: Mon, 8 Mar 2004 15:36:02 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kliment Yanev <Kliment.Yanev@helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
Message-Id: <20040308153602.331f079e.rddunlap@osdl.org>
In-Reply-To: <404D0032.1000807@helsinki.fi>
References: <40408852.8040608@helsinki.fi>
	<20040228104105.5a699d32.rddunlap@osdl.org>
	<40419A1C.5070103@helsinki.fi>
	<20040301101706.3a606d35.rddunlap@osdl.org>
	<404C8A35.3020308@helsinki.fi>
	<20040308090640.2d557f9e.rddunlap@osdl.org>
	<404CF77A.2050301@helsinki.fi>
	<20040308150907.4db68831.rddunlap@osdl.org>
	<404D0032.1000807@helsinki.fi>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2004 01:22:26 +0200 Kliment Yanev wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| 
| 
| Randy.Dunlap wrote:
| 
| |
| | I have no idea where these symbols live or come from.
| 
| I found them! they are in the binary-only part of the driver but for
| some reason they are not getting linked into the .ko file. I tried
| linking them manually but then I get an "invalid module format"

I looked there but didn't see such symbols (using 'nm').
What did you use to see them?
The strings that I see all seem to contain 16-bit characters.


| | You know, it's possible that you could purchase a card that already
| | works on Linux 2.6.... that might be a better solution than trying
| | to use an unknown binary module.

Well, Sam Ravnborg did post a patch in the last week or so that
should help with (some) binary files...  probably .o and not .bin,
or maybe it doesn't matter.


| At this point I am doing this just to see if it will work... I don't
| need the card for another week or so and if I don't get this one to work
| I'll just buy another one. Yet I have the feeling that this card will
| work before long... if only I could get those files linked that is...
| 
| My makefile (dhw, dap, dmgr and dcfg are in the binary parts, present in
| the current dir as dhw.o etc.; all the others are .c files that get
| compiled during a make):
| 
| ~    ifneq ($(KERNELRELEASE),)
| ~    obj-m       := nokia_c110.o
| ~    module-objs := dllc.o dtools.o dhw.o dap.o dmgr.o dcfg.o
| 
| ~    else
| ~    KDIR        := /lib/modules/$(shell uname -r)/build
| ~    PWD         := $(shell pwd)
| 
| ~    default:
| ~        $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
| ~    endif

--
~Randy
